"""RDS data-plane providers backed by PostgreSQL and MySQL."""

from __future__ import annotations

from lws.providers._shared.docker_service import DataPlaneProvider, DockerServiceConfig


class RdsPostgresDataPlaneProvider(DataPlaneProvider):
    """Manages a PostgreSQL container for the RDS data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "rds-postgres-data",
            DockerServiceConfig(
                image="postgres:16-alpine",
                container_name="lws-rds-postgres",
                internal_port=5432,
                host_port=port,
                environment={"POSTGRES_PASSWORD": "lws-local"},
                startup_timeout=30.0,
            ),
        )


class RdsMysqlDataPlaneProvider(DataPlaneProvider):
    """Manages a MySQL container for the RDS data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "rds-mysql-data",
            DockerServiceConfig(
                image="mysql:8",
                container_name="lws-rds-mysql",
                internal_port=3306,
                host_port=port,
                environment={"MYSQL_ROOT_PASSWORD": "lws-local"},
                startup_timeout=60.0,
            ),
        )
