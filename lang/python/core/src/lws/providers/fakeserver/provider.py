"""FakeServerProvider — manages fake server lifecycles."""

from __future__ import annotations

import asyncio
import logging
import socket
from pathlib import Path

import uvicorn

from lws.interfaces.provider import Provider
from lws.providers.fakeserver.engine import RouteMatchEngine
from lws.providers.fakeserver.models import FakeServerConfig
from lws.providers.fakeserver.registry import FakeServerRegistry
from lws.providers.fakeserver.routes import create_fakeserver_app

logger = logging.getLogger(__name__)


async def start_uvicorn_server(
    app: object,
    port: int | socket.socket,
    host: str = "0.0.0.0",
) -> tuple[uvicorn.Server, asyncio.Task]:  # type: ignore[type-arg]
    """Start a uvicorn server and wait for it to bind.

    ``port`` may be an integer port number or a pre-bound ``socket.socket``.
    Passing a pre-bound socket eliminates the TOCTOU race that occurs when
    multiple processes call ``_free_port()`` simultaneously and then race to
    bind the same port.

    Raises OSError if the server fails to bind within the timeout.
    """
    if isinstance(port, socket.socket):
        actual_port = port.getsockname()[1]
        uvi_config = uvicorn.Config(app=app, host=host, port=actual_port, log_level="warning")
        server = uvicorn.Server(uvi_config)
        task = asyncio.create_task(server.serve(sockets=[port]))
    else:
        actual_port = port
        uvi_config = uvicorn.Config(app=app, host=host, port=port, log_level="warning")
        server = uvicorn.Server(uvi_config)
        task = asyncio.create_task(server.serve())
    for _ in range(50):
        if server.started:
            break
        await asyncio.sleep(0.1)
    if not server.started:
        task.cancel()
        raise OSError(f"Failed to bind server on {host}:{actual_port} — port may be in use")
    return server, task


async def stop_uvicorn_server(
    server: uvicorn.Server | None,
    task: asyncio.Task | None,  # type: ignore[type-arg]
) -> None:
    """Gracefully stop a uvicorn server and its task."""
    if server is not None:
        server.should_exit = True
    if task is not None:
        try:
            await asyncio.wait_for(task, timeout=3.0)
        except (TimeoutError, asyncio.CancelledError):
            task.cancel()


class _FakeChildServer:
    """A single fake server running on its own port."""

    def __init__(self, config: FakeServerConfig, port: int) -> None:
        self.config = config
        self.port = port
        self._server: uvicorn.Server | None = None
        self._task: asyncio.Task | None = None  # type: ignore[type-arg]

    async def start(self) -> None:
        """Start the fake server on its configured port."""
        app = create_fakeserver_app(self.config)
        self._server, self._task = await start_uvicorn_server(app, self.port)
        logger.info("Fake server '%s' started on port %d", self.config.name, self.port)

    async def stop(self) -> None:
        """Stop the fake server and clean up resources."""
        await stop_uvicorn_server(self._server, self._task)
        self._server = None
        self._task = None

    def reload(self, config: FakeServerConfig) -> None:
        """Update the config and engine on the running server."""
        self.config = config
        if self._server and self._server.started:
            app = self._server.config.app
            if hasattr(app, "state"):
                app.state.config = config
                app.state.engine = RouteMatchEngine(config.routes)
                app.state.chaos = config.chaos


class FakeServerProvider(Provider):
    """Provider that manages multiple fake HTTP servers."""

    def __init__(self, project_dir: Path, base_port: int = 3100) -> None:
        self._project_dir = project_dir
        self._base_port = base_port
        self._registry = FakeServerRegistry(project_dir / ".lws" / "fakes")
        self._children: dict[str, _FakeChildServer] = {}
        self._next_port_offset = 0

    @property
    def name(self) -> str:
        return "fakeserver"

    @property
    def registry(self) -> FakeServerRegistry:
        """Return the fake server registry."""
        return self._registry

    @property
    def children(self) -> dict[str, _FakeChildServer]:
        """Return a copy of active child servers."""
        return dict(self._children)

    async def start(self) -> None:
        configs = self._registry.load_all()
        for server_name, config in configs.items():
            port = self._allocate_port(config)
            child = _FakeChildServer(config, port)
            await child.start()
            self._children[server_name] = child

    async def stop(self) -> None:
        for child in self._children.values():
            await child.stop()
        self._children.clear()

    async def health_check(self) -> bool:
        return True

    def _allocate_port(self, config: FakeServerConfig) -> int:
        """Allocate a port for a fake server."""
        if config.port is not None:
            return config.port
        port = self._base_port + self._next_port_offset
        self._next_port_offset += 1
        return port

    def server_info(self) -> list[dict]:
        """Return info about all running fake servers."""
        result = []
        for server_name, child in self._children.items():
            result.append(
                {
                    "name": server_name,
                    "port": child.port,
                    "protocol": child.config.protocol,
                    "route_count": len(child.config.routes),
                    "chaos_enabled": child.config.chaos.enabled,
                }
            )
        return result

    async def reload_server(self, server_name: str) -> bool:
        """Reload a single fake server's configuration from disk."""
        config = self._registry.load_one(server_name)
        if config is None:
            # Server was deleted
            child = self._children.pop(server_name, None)
            if child:
                await child.stop()
            return False

        child = self._children.get(server_name)
        if child:
            child.reload(config)
        else:
            port = self._allocate_port(config)
            child = _FakeChildServer(config, port)
            await child.start()
            self._children[server_name] = child
        return True

    async def create_server_in_memory(
        self, name: str, protocol: str = "rest", description: str = ""
    ) -> dict:
        """Create and start a new fake server in memory (no disk storage)."""
        if name in self._children:
            raise ValueError(f"Fake server '{name}' already exists")
        config = FakeServerConfig(name=name, protocol=protocol, description=description)
        port = self._base_port + self._next_port_offset
        self._next_port_offset += 1
        child = _FakeChildServer(config, port)
        await child.start()
        self._children[name] = child
        return {"name": name, "port": port, "protocol": protocol, "route_count": 0}

    async def delete_server_in_memory(self, name: str) -> None:
        """Stop and remove an in-memory fake server."""
        child = self._children.pop(name, None)
        if child is None:
            raise KeyError(f"Fake server '{name}' not found")
        await child.stop()

    def add_route_in_memory(
        self,
        name: str,
        method: str,
        path: str,
        status: int = 200,
        body: object = None,
        headers: dict | None = None,
    ) -> None:
        """Add a route to an in-memory fake server."""
        from lws.providers.fakeserver.models import (  # pylint: disable=import-outside-toplevel
            FakeResponse,
            MatchCriteria,
            RouteRule,
        )

        child = self._children.get(name)
        if child is None:
            raise KeyError(f"Fake server '{name}' not found")
        existing = next(
            (r for r in child.config.routes if r.method == method.upper() and r.path == path),
            None,
        )
        if existing is not None:
            raise ValueError(f"Route {method.upper()} {path} already exists on server '{name}'")
        rule = RouteRule(
            path=path,
            method=method.upper(),
            responses=[
                (MatchCriteria(), FakeResponse(status=status, body=body, headers=headers or {}))
            ],
        )
        child.config.routes.append(rule)
        child.reload(child.config)

    def remove_route_in_memory(self, name: str, method: str, path: str) -> None:
        """Remove a route from an in-memory fake server."""
        child = self._children.get(name)
        if child is None:
            raise KeyError(f"Fake server '{name}' not found")
        before = len(child.config.routes)
        child.config.routes = [
            r for r in child.config.routes if not (r.method == method.upper() and r.path == path)
        ]
        if len(child.config.routes) == before:
            raise KeyError(f"Route {method.upper()} {path} not found on server '{name}'")
        child.reload(child.config)

    async def reset_in_memory(self) -> None:
        """Stop and remove all in-memory fake servers."""
        for name in list(self._children):
            child = self._children.pop(name)
            await child.stop()

    async def reset(self) -> None:
        """Reset all in-memory fake servers (called by management reset endpoint)."""
        await self.reset_in_memory()
