"""MockServerProvider — manages mock server lifecycles."""

from __future__ import annotations

import asyncio
import logging
from pathlib import Path

import uvicorn

from lws.interfaces.provider import Provider
from lws.providers.mockserver.engine import RouteMatchEngine
from lws.providers.mockserver.models import MockServerConfig
from lws.providers.mockserver.registry import MockServerRegistry
from lws.providers.mockserver.routes import create_mockserver_app

logger = logging.getLogger(__name__)


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


class _MockChildServer:
    """A single mock server running on its own port."""

    def __init__(self, config: MockServerConfig, port: int) -> None:
        self.config = config
        self.port = port
        self._server: uvicorn.Server | None = None
        self._task: asyncio.Task | None = None  # type: ignore[type-arg]

    async def start(self) -> None:
        """Start the mock server on its configured port."""
        app = create_mockserver_app(self.config)
        uvi_config = uvicorn.Config(
            app=app,
            host="0.0.0.0",
            port=self.port,
            log_level="warning",
        )
        self._server = uvicorn.Server(uvi_config)
        self._task = asyncio.create_task(self._server.serve())
        for _ in range(50):
            if self._server.started:
                break
            await asyncio.sleep(0.1)
        logger.info("Mock server '%s' started on port %d", self.config.name, self.port)

    async def stop(self) -> None:
        """Stop the mock server and clean up resources."""
        await stop_uvicorn_server(self._server, self._task)
        self._server = None
        self._task = None

    def reload(self, config: MockServerConfig) -> None:
        """Update the config and engine on the running server."""
        self.config = config
        if self._server and self._server.started:
            app = self._server.config.app
            if hasattr(app, "state"):
                app.state.config = config
                app.state.engine = RouteMatchEngine(config.routes)
                app.state.chaos = config.chaos


class MockServerProvider(Provider):
    """Provider that manages multiple mock HTTP servers."""

    def __init__(self, project_dir: Path, base_port: int = 3100) -> None:
        self._project_dir = project_dir
        self._base_port = base_port
        self._registry = MockServerRegistry(project_dir / ".lws" / "mocks")
        self._children: dict[str, _MockChildServer] = {}
        self._next_port_offset = 0

    @property
    def name(self) -> str:
        return "mockserver"

    @property
    def registry(self) -> MockServerRegistry:
        """Return the mock server registry."""
        return self._registry

    @property
    def children(self) -> dict[str, _MockChildServer]:
        """Return a copy of active child servers."""
        return dict(self._children)

    async def start(self) -> None:
        configs = self._registry.load_all()
        for server_name, config in configs.items():
            port = self._allocate_port(config)
            child = _MockChildServer(config, port)
            await child.start()
            self._children[server_name] = child

    async def stop(self) -> None:
        for child in self._children.values():
            await child.stop()
        self._children.clear()

    async def health_check(self) -> bool:
        return True

    def _allocate_port(self, config: MockServerConfig) -> int:
        """Allocate a port for a mock server."""
        if config.port is not None:
            return config.port
        port = self._base_port + self._next_port_offset
        self._next_port_offset += 1
        return port

    def server_info(self) -> list[dict]:
        """Return info about all running mock servers."""
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
        """Reload a single mock server's configuration from disk."""
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
            child = _MockChildServer(config, port)
            await child.start()
            self._children[server_name] = child
        return True
