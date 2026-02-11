"""Shared Docker service manager for data-plane containers.

Manages a single Docker container for services like Redis, MongoDB,
OpenSearch, PostgreSQL, MySQL, and Neo4j.
"""

from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass, field
from pathlib import Path

from lws.logging.logger import get_logger
from lws.providers._shared.docker_client import create_docker_client

_logger = get_logger("ldk.docker-service")


@dataclass
class DockerServiceConfig:
    """Configuration for a Docker-backed data-plane service."""

    image: str
    container_name: str
    internal_port: int
    host_port: int
    environment: dict[str, str] = field(default_factory=dict)
    data_dir: Path | None = None
    health_cmd: list[str] | None = None
    startup_timeout: float = 30.0


class DockerServiceManager:
    """Manages a single Docker container for a data-plane service."""

    def __init__(self, config: DockerServiceConfig) -> None:
        self._config = config
        self._client = None
        self._container = None

    @property
    def endpoint(self) -> str:
        """Return the host endpoint for this service."""
        return f"localhost:{self._config.host_port}"

    async def start(self) -> None:
        """Pull image if needed, create and start the container."""
        self._client = create_docker_client()
        cfg = self._config

        # Pull image if not present
        try:
            self._client.images.get(cfg.image)
        except Exception:
            _logger.info("Pulling image %s ...", cfg.image)
            self._client.images.pull(*cfg.image.rsplit(":", 1))

        # Remove stale container
        try:
            stale = self._client.containers.get(cfg.container_name)
            stale.remove(force=True)
        except Exception:
            pass

        # Build volumes
        volumes = {}
        if cfg.data_dir is not None:
            cfg.data_dir.mkdir(parents=True, exist_ok=True)

        # Start container
        self._container = self._client.containers.run(
            cfg.image,
            detach=True,
            name=cfg.container_name,
            ports={f"{cfg.internal_port}/tcp": cfg.host_port},
            environment=cfg.environment,
            init=True,
        )
        _logger.info(
            "Started container %s (%s) on port %d",
            cfg.container_name,
            cfg.image,
            cfg.host_port,
        )

        # Wait for healthy
        await self._wait_healthy()

    async def _wait_healthy(self) -> None:
        """Wait for the container to become healthy."""
        deadline = time.monotonic() + self._config.startup_timeout
        while time.monotonic() < deadline:
            if await self.health_check():
                return
            await asyncio.sleep(0.5)
        _logger.warning(
            "Container %s did not become healthy within %.0fs",
            self._config.container_name,
            self._config.startup_timeout,
        )

    async def stop(self) -> None:
        """Stop and remove the container."""
        if self._container is None:
            return
        container_name = self._config.container_name
        try:
            self._container.stop(timeout=5)
        except Exception:
            pass
        try:
            self._container.remove(force=True)
        except Exception:
            pass
        self._container = None
        _logger.info("Stopped container %s", container_name)

    async def health_check(self) -> bool:
        """Check if the container is running and healthy."""
        if self._container is None:
            return False
        try:
            self._container.reload()
            if self._container.status != "running":
                return False
        except Exception:
            return False

        if self._config.health_cmd:
            try:
                exit_code, _output = self._container.exec_run(self._config.health_cmd)
                return exit_code == 0
            except Exception:
                return False

        return True
