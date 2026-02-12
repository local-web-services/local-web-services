"""Neptune data-plane provider backed by JanusGraph."""

from __future__ import annotations

from lws.providers._shared.docker_service import DataPlaneProvider, DockerServiceConfig


class NeptuneDataPlaneProvider(DataPlaneProvider):
    """Manages a JanusGraph container for the Neptune data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "neptune-data",
            DockerServiceConfig(
                image="janusgraph/janusgraph:1.0",
                container_name="lws-neptune-janusgraph",
                internal_port=8182,
                host_port=port,
                startup_timeout=60.0,
            ),
        )
