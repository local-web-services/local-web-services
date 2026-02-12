"""MemoryDB HTTP routes.

Implements the MemoryDB wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import time
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers._shared.response_helpers import (
    error_response as _error_response_base,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers._shared.response_helpers import (
    parse_endpoint as _parse_endpoint,
)
from lws.providers._shared.resource_container import ResourceContainerManager

_logger = get_logger("ldk.memorydb")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _MemoryDBCluster:
    """Represents a MemoryDB cluster."""

    def __init__(
        self,
        cluster_name: str,
        node_type: str = "db.t4g.small",
        num_shards: int = 1,
        tags: dict[str, str] | None = None,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.cluster_name = cluster_name
        self.node_type = node_type
        self.num_shards = num_shards
        self.status = "available"
        self.arn = f"arn:aws:memorydb:{_REGION}:{_ACCOUNT_ID}:cluster/{cluster_name}"
        if data_plane_endpoint:
            addr, pt = _parse_endpoint(data_plane_endpoint)
            self.endpoint: dict[str, Any] = {"Address": addr, "Port": pt}
        else:
            self.endpoint = {"Address": f"{cluster_name}.memorydb.localhost", "Port": 6379}
        self.tags: dict[str, str] = tags or {}
        self.created_date: float = time.time()


class _MemoryDBState:
    """In-memory store for MemoryDB resources."""

    def __init__(self, *, container_manager: ResourceContainerManager | None = None) -> None:
        self._clusters: dict[str, _MemoryDBCluster] = {}
        self.container_manager = container_manager

    @property
    def clusters(self) -> dict[str, _MemoryDBCluster]:
        """Return the clusters store."""
        return self._clusters


# ------------------------------------------------------------------
# Action handlers — Clusters
# ------------------------------------------------------------------


async def _handle_create_cluster(state: _MemoryDBState, body: dict) -> Response:
    cluster_name = body.get("ClusterName", "")
    if not cluster_name:
        return _error_response(
            "InvalidParameterValue",
            "ClusterName is required.",
        )

    if cluster_name in state.clusters:
        return _error_response(
            "ClusterAlreadyExistsFault",
            f"Cluster {cluster_name} already exists.",
        )

    node_type = body.get("NodeType", "db.t4g.small")
    num_shards = body.get("NumShards", 1)
    tags_list = body.get("Tags", [])
    tags = {t["Key"]: t["Value"] for t in tags_list} if tags_list else {}

    endpoint = None
    if state.container_manager:
        endpoint = await state.container_manager.start_container(cluster_name)
    cluster = _MemoryDBCluster(
        cluster_name=cluster_name,
        node_type=node_type,
        num_shards=num_shards,
        tags=tags,
        data_plane_endpoint=endpoint,
    )
    state.clusters[cluster_name] = cluster

    return _json_response({"Cluster": _format_cluster(cluster)})


async def _handle_describe_clusters(state: _MemoryDBState, body: dict) -> Response:
    cluster_name = body.get("ClusterName")

    if cluster_name:
        cluster = state.clusters.get(cluster_name)
        if cluster is None:
            return _error_response(
                "ClusterNotFoundFault",
                f"Cluster {cluster_name} not found.",
            )
        return _json_response({"Clusters": [_format_cluster(cluster)]})

    clusters = [_format_cluster(c) for c in state.clusters.values()]
    return _json_response({"Clusters": clusters})


async def _handle_delete_cluster(state: _MemoryDBState, body: dict) -> Response:
    cluster_name = body.get("ClusterName", "")
    cluster = state.clusters.get(cluster_name)
    if cluster is None:
        return _error_response(
            "ClusterNotFoundFault",
            f"Cluster {cluster_name} not found.",
        )

    del state.clusters[cluster_name]
    cluster.status = "deleted"
    return _json_response({"Cluster": _format_cluster(cluster)})


async def _handle_update_cluster(state: _MemoryDBState, body: dict) -> Response:
    cluster_name = body.get("ClusterName", "")
    cluster = state.clusters.get(cluster_name)
    if cluster is None:
        return _error_response(
            "ClusterNotFoundFault",
            f"Cluster {cluster_name} not found.",
        )

    if "NodeType" in body:
        cluster.node_type = body["NodeType"]
    if "NumShards" in body:
        cluster.num_shards = body["NumShards"]

    return _json_response({"Cluster": _format_cluster(cluster)})


# ------------------------------------------------------------------
# Action handlers — Tags
# ------------------------------------------------------------------


async def _handle_list_tags(state: _MemoryDBState, body: dict) -> Response:
    resource_arn = body.get("ResourceArn", "")
    cluster = _find_cluster_by_arn(state, resource_arn)
    if cluster is None:
        return _error_response(
            "ClusterNotFoundFault",
            f"Resource {resource_arn} not found.",
        )

    tag_list = [{"Key": k, "Value": v} for k, v in cluster.tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_tag_resource(state: _MemoryDBState, body: dict) -> Response:
    resource_arn = body.get("ResourceArn", "")
    tags_list = body.get("Tags", [])

    cluster = _find_cluster_by_arn(state, resource_arn)
    if cluster is None:
        return _error_response(
            "ClusterNotFoundFault",
            f"Resource {resource_arn} not found.",
        )

    for tag in tags_list:
        cluster.tags[tag["Key"]] = tag["Value"]

    result_tags = [{"Key": k, "Value": v} for k, v in cluster.tags.items()]
    return _json_response({"TagList": result_tags})


async def _handle_untag_resource(state: _MemoryDBState, body: dict) -> Response:
    resource_arn = body.get("ResourceArn", "")
    tag_keys = body.get("TagKeys", [])

    cluster = _find_cluster_by_arn(state, resource_arn)
    if cluster is None:
        return _error_response(
            "ClusterNotFoundFault",
            f"Resource {resource_arn} not found.",
        )

    for key in tag_keys:
        cluster.tags.pop(key, None)

    result_tags = [{"Key": k, "Value": v} for k, v in cluster.tags.items()]
    return _json_response({"TagList": result_tags})


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _find_cluster_by_arn(state: _MemoryDBState, arn: str) -> _MemoryDBCluster | None:
    """Find a cluster by ARN."""
    for cluster in state.clusters.values():
        if cluster.arn == arn:
            return cluster
    return None


def _format_cluster(cluster: _MemoryDBCluster) -> dict[str, Any]:
    """Format a MemoryDB cluster for API response."""
    return {
        "Name": cluster.cluster_name,
        "NodeType": cluster.node_type,
        "NumShards": cluster.num_shards,
        "Status": cluster.status,
        "ARN": cluster.arn,
        "ClusterEndpoint": cluster.endpoint,
        "CreatedDate": cluster.created_date,
    }


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in MemoryDB format (lowercase 'message' key)."""
    return _error_response_base(code, message, status_code=status_code, message_key="message")


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateCluster": _handle_create_cluster,
    "DescribeClusters": _handle_describe_clusters,
    "DeleteCluster": _handle_delete_cluster,
    "UpdateCluster": _handle_update_cluster,
    "ListTags": _handle_list_tags,
    "TagResource": _handle_tag_resource,
    "UntagResource": _handle_untag_resource,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_memorydb_app(*, data_plane_endpoint: str | None = None) -> FastAPI:
    """Create a FastAPI application that speaks the MemoryDB wire protocol."""
    app = FastAPI(title="LDK MemoryDB")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="memorydb")
    state = _MemoryDBState(data_plane_endpoint=data_plane_endpoint)

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown MemoryDB action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: MemoryDB operation '{action}' is not yet implemented",
            )

        return await handler(state, body)

    return app
