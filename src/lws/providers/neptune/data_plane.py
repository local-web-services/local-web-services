"""Neptune data-plane provider backed by JanusGraph.

Runs a JanusGraph Docker container exposing Gremlin Server on port 8182.
If Docker is unavailable the provider logs a warning and continues —
the control-plane will still work but with synthetic endpoints.
"""

from __future__ import annotations

from lws.interfaces import Provider
from lws.logging.logger import get_logger
from lws.providers._shared.docker_service import DockerServiceConfig, DockerServiceManager

_logger = get_logger("ldk.neptune-data")


class NeptuneDataPlaneProvider(Provider):
    """Manages a JanusGraph container for the Neptune data-plane."""

    def __init__(self, port: int) -> None:
        self._docker = DockerServiceManager(
            DockerServiceConfig(
                image="janusgraph/janusgraph:1.0",
                container_name="lws-neptune-janusgraph",
                internal_port=8182,
                host_port=port,
                startup_timeout=60.0,
            )
        )
        self._started = False

    @property
    def name(self) -> str:
        """Return provider name."""
        return "neptune-data"

    @property
    def endpoint(self) -> str:
        """Return the host endpoint for the JanusGraph Gremlin Server."""
        return self._docker.endpoint

    @property
    def available(self) -> bool:
        """Return True if the JanusGraph container started successfully."""
        return self._started

    async def start(self) -> None:
        """Start the JanusGraph container, or skip if Docker is unavailable."""
        try:
            await self._docker.start()
            self._started = True
        except Exception:
            _logger.debug("Neptune data-plane container did not start")

    async def stop(self) -> None:
        """Stop the JanusGraph container if it was started."""
        if self._started:
            await self._docker.stop()

    async def health_check(self) -> bool:
        """Check container health."""
        if not self._started:
            return True  # Not a failure — just not available
        return await self._docker.health_check()
