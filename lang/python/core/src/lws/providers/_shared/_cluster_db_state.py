"""In-memory state classes and helper formatters for cluster-DB providers."""

from __future__ import annotations

from typing import Any

from fastapi import Response

from lws.providers._shared.response_helpers import error_response as _error_response

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


def _iso_now() -> str:
    """Return current UTC time in ISO-8601 format."""
    import datetime  # pylint: disable=import-outside-toplevel

    return datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.000Z")


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
        initial_status: str = "available",
    ) -> None:
        self.db_cluster_identifier = db_cluster_identifier
        self.engine = engine
        self.master_username = master_username
        self.status = initial_status
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


class _DBClusterSnapshot:
    """Represents a cluster snapshot in a cluster-DB service."""

    def __init__(
        self,
        snapshot_identifier: str,
        cluster_identifier: str,
        engine: str,
        *,
        config: Any,
    ) -> None:
        self.snapshot_identifier = snapshot_identifier
        self.cluster_identifier = cluster_identifier
        self.engine = engine
        self.status = "available"
        self.created_date = _iso_now()
        self.arn = (
            f"arn:aws:{config.arn_service}:{_REGION}:{_ACCOUNT_ID}"
            f":cluster-snapshot:{snapshot_identifier}"
        )


class _ClusterDBState:
    """In-memory store for clusters and instances."""

    def __init__(self) -> None:
        self.clusters: dict[str, _DBCluster] = {}
        self.instances: dict[str, _DBInstance] = {}
        self.snapshots: dict[str, _DBClusterSnapshot] = {}


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _cluster_not_found_guard(cid: str, cluster: _DBCluster | None) -> Response | None:
    """Return an error response if cluster is None, else None."""
    if cluster is None:
        return _error_response(
            "DBClusterNotFoundFault",
            f"Cluster {cid} not found.",
        )
    return None


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


def _describe_snapshot(snapshot: _DBClusterSnapshot) -> dict[str, Any]:
    """Format a cluster snapshot for API response."""
    return {
        "DBClusterSnapshotIdentifier": snapshot.snapshot_identifier,
        "DBClusterIdentifier": snapshot.cluster_identifier,
        "Engine": snapshot.engine,
        "Status": snapshot.status,
        "DBClusterSnapshotArn": snapshot.arn,
        "SnapshotCreateTime": snapshot.created_date,
    }


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
