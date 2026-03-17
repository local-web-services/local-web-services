"""RDS in-memory state classes and helpers."""

from __future__ import annotations

from typing import Any

from lws.providers._shared.response_helpers import (
    iso_now as _iso_now,
)
from lws.providers._shared.response_helpers import (
    parse_endpoint as _parse_endpoint,
)
from lws.providers._shared.resource_container import ResourceContainerManager

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


class _DBInstance:
    """Represents an RDS DB instance."""

    def __init__(
        self,
        db_instance_identifier: str,
        db_instance_class: str,
        engine: str,
        master_username: str,
        allocated_storage: int,
        db_cluster_identifier: str | None = None,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_instance_identifier = db_instance_identifier
        self.db_instance_class = db_instance_class
        self.engine = engine
        self.master_username = master_username
        self.allocated_storage = allocated_storage
        self.status = "available"
        self.arn = f"arn:aws:rds:{_REGION}:{_ACCOUNT_ID}:db:{db_instance_identifier}"
        if data_plane_endpoint:
            addr, pt = _parse_endpoint(data_plane_endpoint)
            self.endpoint = {"Address": addr, "Port": pt}
        else:
            self.endpoint = {
                "Address": f"{db_instance_identifier}.local.{_REGION}.rds.amazonaws.com",
                "Port": 5432 if engine == "postgres" else 3306,
            }
        self.db_cluster_identifier = db_cluster_identifier
        self.tags: dict[str, str] = {}
        self.created_date = _iso_now()


class _DBCluster:
    """Represents an RDS DB cluster."""

    def __init__(
        self,
        db_cluster_identifier: str,
        engine: str,
        master_username: str,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_cluster_identifier = db_cluster_identifier
        self.engine = engine
        self.master_username = master_username
        self.status = "available"
        self.arn = f"arn:aws:rds:{_REGION}:{_ACCOUNT_ID}:cluster:{db_cluster_identifier}"
        if data_plane_endpoint:
            self.endpoint, self.port = _parse_endpoint(data_plane_endpoint)
        else:
            self.endpoint = f"{db_cluster_identifier}.cluster-local.{_REGION}.rds.amazonaws.com"
            self.port = 5432 if engine == "postgres" else 3306
        self.tags: dict[str, str] = {}
        self.created_date = _iso_now()


class _RdsState:
    """In-memory store for RDS instances and clusters."""

    def __init__(
        self,
        *,
        postgres_container_manager: ResourceContainerManager | None = None,
        mysql_container_manager: ResourceContainerManager | None = None,
    ) -> None:
        self._instances: dict[str, _DBInstance] = {}
        self._clusters: dict[str, _DBCluster] = {}
        self.postgres_container_manager = postgres_container_manager
        self.mysql_container_manager = mysql_container_manager

    @property
    def instances(self) -> dict[str, _DBInstance]:
        """Return the instances store."""
        return self._instances

    @property
    def clusters(self) -> dict[str, _DBCluster]:
        """Return the clusters store."""
        return self._clusters


def _format_db_instance(instance: _DBInstance) -> dict[str, Any]:
    """Format a DB instance for API response."""
    result: dict[str, Any] = {
        "DBInstanceIdentifier": instance.db_instance_identifier,
        "DBInstanceClass": instance.db_instance_class,
        "Engine": instance.engine,
        "DBInstanceStatus": instance.status,
        "MasterUsername": instance.master_username,
        "AllocatedStorage": instance.allocated_storage,
        "Endpoint": instance.endpoint,
        "DBInstanceArn": instance.arn,
        "InstanceCreateTime": instance.created_date,
        "TagList": [{"Key": k, "Value": v} for k, v in instance.tags.items()],
    }
    if instance.db_cluster_identifier is not None:
        result["DBClusterIdentifier"] = instance.db_cluster_identifier
    return result


def _format_db_cluster(cluster: _DBCluster) -> dict[str, Any]:
    """Format a DB cluster for API response."""
    return {
        "DBClusterIdentifier": cluster.db_cluster_identifier,
        "Engine": cluster.engine,
        "Status": cluster.status,
        "MasterUsername": cluster.master_username,
        "Endpoint": cluster.endpoint,
        "Port": cluster.port,
        "DBClusterArn": cluster.arn,
        "ClusterCreateTime": cluster.created_date,
        "TagList": [{"Key": k, "Value": v} for k, v in cluster.tags.items()],
    }


def _find_resource_tags(state: _RdsState, resource_arn: str) -> dict[str, str] | None:
    """Find the tags dict for a resource by its ARN. Returns None if not found."""
    for instance in state.instances.values():
        if instance.arn == resource_arn:
            return instance.tags
    for cluster in state.clusters.values():
        if cluster.arn == resource_arn:
            return cluster.tags
    return None


_ENGINE_VERSIONS: dict[str, list[dict[str, Any]]] = {
    "postgres": [
        {
            "Engine": "postgres",
            "EngineVersion": "14.17",
            "DBParameterGroupFamily": "postgres14",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 14.17",
        },
        {
            "Engine": "postgres",
            "EngineVersion": "15.12",
            "DBParameterGroupFamily": "postgres15",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 15.12",
        },
        {
            "Engine": "postgres",
            "EngineVersion": "16.8",
            "DBParameterGroupFamily": "postgres16",
            "DBEngineDescription": "PostgreSQL",
            "DBEngineVersionDescription": "PostgreSQL 16.8",
        },
    ],
    "mysql": [
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.36",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.36",
        },
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.37",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.37",
        },
        {
            "Engine": "mysql",
            "EngineVersion": "8.0.39",
            "DBParameterGroupFamily": "mysql8.0",
            "DBEngineDescription": "MySQL Community Edition",
            "DBEngineVersionDescription": "MySQL 8.0.39",
        },
    ],
}
