"""In-memory state classes and helper formatters for cluster-DB providers."""

from __future__ import annotations

from typing import Any

from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _DBCluster:
    """Represents a cluster in a cluster-DB service."""

    def __init__(
        self,
        db_cluster_identifier: str,
        engine: str,
        master_username: str,
        *,
        config: Any,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_cluster_identifier = db_cluster_identifier
        self.engine = engine
        self.master_username = master_username
        self.status = "available"
        self.port = config.default_port
        self.arn = (
            f"arn:aws:{config.arn_service}:{_REGION}:{_ACCOUNT_ID}"
            f":cluster:{db_cluster_identifier}"
        )
        if data_plane_endpoint:
            self.endpoint = data_plane_endpoint
        else:
            self.endpoint = (
                f"{db_cluster_identifier}.cluster-local" f".{_REGION}.{config.endpoint_suffix}"
            )
        self.tags: dict[str, str] = {}


class _DBInstance:
    """Represents an instance in a cluster-DB service."""

    def __init__(
        self,
        db_instance_identifier: str,
        db_instance_class: str,
        engine: str,
        db_cluster_identifier: str,
        *,
        config: Any,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.db_instance_identifier = db_instance_identifier
        self.db_instance_class = db_instance_class
        self.engine = engine
        self.db_cluster_identifier = db_cluster_identifier
        self.status = "available"
        self.arn = (
            f"arn:aws:{config.arn_service}:{_REGION}:{_ACCOUNT_ID}" f":db:{db_instance_identifier}"
        )
        if data_plane_endpoint:
            self.endpoint = data_plane_endpoint
        else:
            self.endpoint = (
                f"{db_instance_identifier}.cluster-local" f".{_REGION}.{config.endpoint_suffix}"
            )
        self.tags: dict[str, str] = {}


class _ClusterDBState:
    """In-memory store for clusters and instances."""

    def __init__(self) -> None:
        self.clusters: dict[str, _DBCluster] = {}
        self.instances: dict[str, _DBInstance] = {}


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _apply_tags(tags: dict[str, str], tag_list: list[dict[str, str]]) -> None:
    """Merge a list of {Key, Value} dicts into a tags dict."""
    for tag in tag_list:
        tags[tag["Key"]] = tag["Value"]


def _find_tags_by_arn(state: _ClusterDBState, arn: str) -> dict[str, str]:
    """Look up the tags dict for a resource by its ARN."""
    for cluster in state.clusters.values():
        if cluster.arn == arn:
            return cluster.tags
    for instance in state.instances.values():
        if instance.arn == arn:
            return instance.tags
    return {}


def _describe_cluster(cluster: _DBCluster, config: Any) -> dict[str, Any]:
    """Format a cluster for API response."""
    result: dict[str, Any] = {
        "DBClusterIdentifier": cluster.db_cluster_identifier,
        "Engine": cluster.engine,
        "Status": cluster.status,
        "Endpoint": cluster.endpoint,
        "Port": cluster.port,
        "DBClusterArn": cluster.arn,
    }
    if config.include_master_username:
        result["MasterUsername"] = cluster.master_username
    if cluster.tags:
        result["TagList"] = [{"Key": k, "Value": v} for k, v in cluster.tags.items()]
    return result


def _describe_instance(instance: _DBInstance) -> dict[str, Any]:
    """Format an instance for API response."""
    result: dict[str, Any] = {
        "DBInstanceIdentifier": instance.db_instance_identifier,
        "DBInstanceClass": instance.db_instance_class,
        "Engine": instance.engine,
        "DBClusterIdentifier": instance.db_cluster_identifier,
        "DBInstanceStatus": instance.status,
        "Endpoint": {"Address": instance.endpoint},
        "DBInstanceArn": instance.arn,
    }
    if instance.tags:
        result["TagList"] = [{"Key": k, "Value": v} for k, v in instance.tags.items()]
    return result
