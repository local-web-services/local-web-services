"""DocumentDB data-plane provider backed by MongoDB."""

from __future__ import annotations

from lws.providers._shared.docker_service import DataPlaneProvider, DockerServiceConfig


class DocDBDataPlaneProvider(DataPlaneProvider):
    """Manages a MongoDB container for the DocumentDB data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "docdb-data",
            DockerServiceConfig(
                image="mongo:7",
                container_name="lws-docdb-mongo",
                internal_port=27017,
                host_port=port,
                startup_timeout=30.0,
            ),
        )
