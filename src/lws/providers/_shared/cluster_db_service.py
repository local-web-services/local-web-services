"""Shared cluster-DB factory for DocumentDB and Neptune providers.

Both services share nearly identical cluster/instance CRUD, tag management,
and response formatting logic.  This module parameterises the differences
via a config dataclass so each provider is a thin wrapper.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers._shared.resource_container import ResourceContainerManager

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# Config
# ------------------------------------------------------------------


@dataclass
class ClusterDBConfig:
    """Configuration that varies between DocumentDB and Neptune."""

    service_name: str
    display_name: str
    logger_name: str
    arn_service: str
    default_engine: str
    default_port: int
    default_instance_class: str
    endpoint_suffix: str
    include_master_username: bool = False
    include_remove_tags: bool = True
    container_manager: ResourceContainerManager | None = None


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
        config: ClusterDBConfig,
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
        config: ClusterDBConfig,
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


def _describe_cluster(cluster: _DBCluster, config: ClusterDBConfig) -> dict[str, Any]:
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


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_create_db_cluster(
    state: _ClusterDBState, body: dict, config: ClusterDBConfig
) -> Response:
    cid = body.get("DBClusterIdentifier", "")
    if cid in state.clusters:
        return _error_response(
            "DBClusterAlreadyExistsFault",
            f"Cluster {cid} already exists.",
        )

    endpoint = None
    if config.container_manager:
        endpoint = await config.container_manager.start_container(cid)
    cluster = _DBCluster(
        db_cluster_identifier=cid,
        engine=body.get("Engine", config.default_engine),
        master_username=body.get("MasterUsername", ""),
        config=config,
        data_plane_endpoint=endpoint,
    )
    _apply_tags(cluster.tags, body.get("Tags", []))
    state.clusters[cid] = cluster
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def _handle_describe_db_clusters(
    state: _ClusterDBState, body: dict, config: ClusterDBConfig
) -> Response:
    cid = body.get("DBClusterIdentifier")
    if cid:
        cluster = state.clusters.get(cid)
        if cluster is None:
            return _error_response(
                "DBClusterNotFoundFault",
                f"Cluster {cid} not found.",
            )
        return _json_response({"DBClusters": [_describe_cluster(cluster, config)]})
    clusters = [_describe_cluster(c, config) for c in state.clusters.values()]
    return _json_response({"DBClusters": clusters})


async def _handle_delete_db_cluster(
    state: _ClusterDBState, body: dict, config: ClusterDBConfig
) -> Response:
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.pop(cid, None)
    if cluster is None:
        return _error_response(
            "DBClusterNotFoundFault",
            f"Cluster {cid} not found.",
        )
    cluster.status = "deleting"
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def _handle_create_db_instance(
    state: _ClusterDBState, body: dict, config: ClusterDBConfig
) -> Response:
    iid = body.get("DBInstanceIdentifier", "")
    if iid in state.instances:
        return _error_response(
            "DBInstanceAlreadyExistsFault",
            f"Instance {iid} already exists.",
        )

    instance = _DBInstance(
        db_instance_identifier=iid,
        db_instance_class=body.get("DBInstanceClass", config.default_instance_class),
        engine=body.get("Engine", config.default_engine),
        db_cluster_identifier=body.get("DBClusterIdentifier", ""),
        config=config,
    )
    _apply_tags(instance.tags, body.get("Tags", []))
    state.instances[iid] = instance
    return _json_response({"DBInstance": _describe_instance(instance)})


async def _handle_describe_db_instances(
    state: _ClusterDBState, body: dict, _config: ClusterDBConfig
) -> Response:
    iid = body.get("DBInstanceIdentifier")
    if iid:
        instance = state.instances.get(iid)
        if instance is None:
            return _error_response(
                "DBInstanceNotFoundFault",
                f"Instance {iid} not found.",
            )
        return _json_response({"DBInstances": [_describe_instance(instance)]})
    instances = [_describe_instance(i) for i in state.instances.values()]
    return _json_response({"DBInstances": instances})


async def _handle_delete_db_instance(
    state: _ClusterDBState, body: dict, _config: ClusterDBConfig
) -> Response:
    iid = body.get("DBInstanceIdentifier", "")
    instance = state.instances.pop(iid, None)
    if instance is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Instance {iid} not found.",
        )
    instance.status = "deleting"
    return _json_response({"DBInstance": _describe_instance(instance)})


async def _handle_list_tags(
    state: _ClusterDBState, body: dict, _config: ClusterDBConfig
) -> Response:
    arn = body.get("ResourceName", "")
    tags = _find_tags_by_arn(state, arn)
    tag_list = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_add_tags(
    state: _ClusterDBState, body: dict, _config: ClusterDBConfig
) -> Response:
    arn = body.get("ResourceName", "")
    tags = _find_tags_by_arn(state, arn)
    _apply_tags(tags, body.get("Tags", []))
    return _json_response({})


async def _handle_remove_tags(
    state: _ClusterDBState, body: dict, _config: ClusterDBConfig
) -> Response:
    arn = body.get("ResourceName", "")
    tags = _find_tags_by_arn(state, arn)
    for key in body.get("TagKeys", []):
        tags.pop(key, None)
    return _json_response({})


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_cluster_db_app(config: ClusterDBConfig) -> FastAPI:
    """Create a FastAPI app that speaks a cluster-DB wire protocol."""
    logger = get_logger(config.logger_name)
    app = FastAPI(title=f"LDK {config.display_name}")
    app.add_middleware(RequestLoggingMiddleware, logger=logger, service_name=config.service_name)
    state = _ClusterDBState()

    action_handlers: dict[str, Any] = {
        "CreateDBCluster": _handle_create_db_cluster,
        "DescribeDBClusters": _handle_describe_db_clusters,
        "DeleteDBCluster": _handle_delete_db_cluster,
        "CreateDBInstance": _handle_create_db_instance,
        "DescribeDBInstances": _handle_describe_db_instances,
        "DeleteDBInstance": _handle_delete_db_instance,
        "ListTagsForResource": _handle_list_tags,
        "AddTagsToResource": _handle_add_tags,
    }
    if config.include_remove_tags:
        action_handlers["RemoveTagsFromResource"] = _handle_remove_tags

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = action_handlers.get(action)
        if handler is None:
            logger.warning("Unknown %s action: %s", config.display_name, action)
            return _error_response(
                "InvalidAction",
                f"lws: {config.display_name} operation '{action}' is not yet implemented",
            )

        return await handler(state, body, config)

    return app
