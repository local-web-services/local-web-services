"""ElastiCache data-plane provider backed by Redis."""

from __future__ import annotations

from lws.providers._shared.docker_service import DataPlaneProvider, DockerServiceConfig


class ElastiCacheDataPlaneProvider(DataPlaneProvider):
    """Manages a Redis container for the ElastiCache data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "elasticache-data",
            DockerServiceConfig(
                image="redis:7-alpine",
                container_name="lws-elasticache-redis",
                internal_port=6379,
                host_port=port,
                startup_timeout=30.0,
            ),
        )
