"""Neptune data-plane provider backed by JanusGraph.

Runs a JanusGraph Docker container exposing Gremlin Server on port 8182.
"""

from __future__ import annotations

from lws.interfaces import Provider
from lws.providers._shared.docker_service import DockerServiceConfig, DockerServiceManager


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

    @property
    def name(self) -> str:  # noqa: D102
        """Return provider name."""
        return "neptune-data"

    @property
    def endpoint(self) -> str:
        """Return the host endpoint for the JanusGraph Gremlin Server."""
        return self._docker.endpoint

    async def start(self) -> None:
        await self._docker.start()

    async def stop(self) -> None:
        await self._docker.stop()

    async def health_check(self) -> bool:
        return await self._docker.health_check()
