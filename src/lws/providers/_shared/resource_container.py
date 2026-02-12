"""Per-resource Docker container manager.

Creates and destroys Docker containers on demand when resources are
created or deleted via control-plane APIs.  Each container is named
``lws-{service_prefix}-{resource_id}`` and bound to a dynamically
allocated host port.
"""

from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass, field

from lws.logging.logger import get_logger
from lws.providers._shared.docker_client import create_docker_client
from lws.providers._shared.docker_service import destroy_container

_logger = get_logger("ldk.resource-container")


@dataclass
class ResourceContainerConfig:
    """Configuration for per-resource Docker containers."""

    image: str
    internal_port: int
    environment: dict[str, str] = field(default_factory=dict)
    startup_timeout: float = 30.0


class ResourceContainerManager:
    """Manages per-resource Docker containers for a single service."""

    def __init__(self, service_prefix: str, config: ResourceContainerConfig) -> None:
        self._prefix = service_prefix
        self._config = config
        self._containers: dict[str, object] = {}

    def _container_name(self, resource_id: str) -> str:
        return f"lws-{self._prefix}-{resource_id}"

    async def start_container(self, resource_id: str) -> str | None:
        """Start a container for *resource_id*.

        Returns ``"localhost:{port}"`` on success or ``None`` when Docker
        is unavailable or the image has not been pulled.
        """
        try:
            client = create_docker_client()
        except Exception:
            _logger.debug("Docker not available for %s", self._prefix)
            return None

        cfg = self._config
        try:
            client.images.get(cfg.image)
        except Exception:
            _logger.debug("Image %s not found locally", cfg.image)
            return None

        name = self._container_name(resource_id)

        # Remove stale container with same name
        try:
            stale = client.containers.get(name)
            stale.remove(force=True)
        except Exception:
            pass

        try:
            container = client.containers.run(
                cfg.image,
                detach=True,
                name=name,
                ports={f"{cfg.internal_port}/tcp": None},
                environment=cfg.environment or {},
                init=True,
            )
        except Exception:
            _logger.warning("Failed to start container %s", name)
            return None

        # Discover the dynamically assigned host port
        try:
            container.reload()
            port_bindings = container.attrs["NetworkSettings"]["Ports"]
            host_port = int(port_bindings[f"{cfg.internal_port}/tcp"][0]["HostPort"])
        except Exception:
            _logger.warning("Failed to discover port for %s", name)
            destroy_container(container)
            return None

        self._containers[resource_id] = container

        # Wait for the container to become ready
        deadline = time.monotonic() + cfg.startup_timeout
        while time.monotonic() < deadline:
            try:
                container.reload()
                if container.status == "running":
                    break
            except Exception:
                pass
            await asyncio.sleep(0.5)

        endpoint = f"localhost:{host_port}"
        _logger.info("Started container %s on %s", name, endpoint)
        return endpoint

    async def stop_container(self, resource_id: str) -> None:
        """Stop and remove the container for *resource_id*."""
        container = self._containers.pop(resource_id, None)
        if container is None:
            return
        name = self._container_name(resource_id)
        destroy_container(container)
        _logger.info("Stopped container %s", name)

    async def stop_all(self) -> None:
        """Stop all containers managed by this instance."""
        for resource_id in list(self._containers):
            await self.stop_container(resource_id)
