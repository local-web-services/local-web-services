"""ElastiCache HTTP routes.

Implements the ElastiCache wire protocol that AWS SDKs and Terraform use,
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

_logger = get_logger("ldk.elasticache")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _CacheCluster:
    """Represents an ElastiCache cache cluster."""

    def __init__(
        self,
        cache_cluster_id: str,
        engine: str = "redis",
        num_cache_nodes: int = 1,
        cache_node_type: str = "cache.t3.micro",
        tags: dict[str, str] | None = None,
    ) -> None:
        self.cache_cluster_id = cache_cluster_id
        self.engine = engine
        self.num_cache_nodes = num_cache_nodes
        self.cache_node_type = cache_node_type
        self.status = "available"
        self.arn = f"arn:aws:elasticache:{_REGION}:{_ACCOUNT_ID}:cluster:{cache_cluster_id}"
        self.endpoint: dict[str, Any] = {
            "Address": f"{cache_cluster_id}.cache.localhost",
            "Port": 6379,
        }
        self.tags: dict[str, str] = tags or {}
        self.created_date: float = time.time()


class _ReplicationGroup:
    """Represents an ElastiCache replication group."""

    def __init__(
        self,
        replication_group_id: str,
        description: str = "",
        member_clusters: list[str] | None = None,
        tags: dict[str, str] | None = None,
    ) -> None:
        self.replication_group_id = replication_group_id
        self.description = description
        self.status = "available"
        self.member_clusters: list[str] = member_clusters or []
        self.arn = (
            f"arn:aws:elasticache:{_REGION}:{_ACCOUNT_ID}"
            f":replicationgroup:{replication_group_id}"
        )
        self.tags: dict[str, str] = tags or {}


class _ElastiCacheState:
    """In-memory store for ElastiCache resources."""

    def __init__(self) -> None:
        self._clusters: dict[str, _CacheCluster] = {}
        self._replication_groups: dict[str, _ReplicationGroup] = {}

    @property
    def clusters(self) -> dict[str, _CacheCluster]:
        """Return the clusters store."""
        return self._clusters

    @property
    def replication_groups(self) -> dict[str, _ReplicationGroup]:
        """Return the replication groups store."""
        return self._replication_groups


# ------------------------------------------------------------------
# Action handlers — Cache Clusters
# ------------------------------------------------------------------


async def _handle_create_cache_cluster(state: _ElastiCacheState, body: dict) -> Response:
    cluster_id = body.get("CacheClusterId", "")
    if not cluster_id:
        return _error_response(
            "InvalidParameterValue",
            "CacheClusterId is required.",
        )

    if cluster_id in state.clusters:
        return _error_response(
            "CacheClusterAlreadyExists",
            f"Cache cluster {cluster_id} already exists.",
        )

    engine = body.get("Engine", "redis")
    num_cache_nodes = body.get("NumCacheNodes", 1)
    cache_node_type = body.get("CacheNodeType", "cache.t3.micro")
    tags_list = body.get("Tags", [])
    tags = {t["Key"]: t["Value"] for t in tags_list} if tags_list else {}

    cluster = _CacheCluster(
        cache_cluster_id=cluster_id,
        engine=engine,
        num_cache_nodes=num_cache_nodes,
        cache_node_type=cache_node_type,
        tags=tags,
    )
    state.clusters[cluster_id] = cluster

    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


async def _handle_describe_cache_clusters(state: _ElastiCacheState, body: dict) -> Response:
    cluster_id = body.get("CacheClusterId")

    if cluster_id:
        cluster = state.clusters.get(cluster_id)
        if cluster is None:
            return _error_response(
                "CacheClusterNotFound",
                f"Cache cluster {cluster_id} not found.",
            )
        return _json_response({"CacheClusters": [_format_cache_cluster(cluster)]})

    clusters = [_format_cache_cluster(c) for c in state.clusters.values()]
    return _json_response({"CacheClusters": clusters})


async def _handle_delete_cache_cluster(state: _ElastiCacheState, body: dict) -> Response:
    cluster_id = body.get("CacheClusterId", "")
    cluster = state.clusters.get(cluster_id)
    if cluster is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Cache cluster {cluster_id} not found.",
        )

    del state.clusters[cluster_id]
    cluster.status = "deleted"
    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


async def _handle_modify_cache_cluster(state: _ElastiCacheState, body: dict) -> Response:
    cluster_id = body.get("CacheClusterId", "")
    cluster = state.clusters.get(cluster_id)
    if cluster is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Cache cluster {cluster_id} not found.",
        )

    if "NumCacheNodes" in body:
        cluster.num_cache_nodes = body["NumCacheNodes"]
    if "CacheNodeType" in body:
        cluster.cache_node_type = body["CacheNodeType"]
    if "Engine" in body:
        cluster.engine = body["Engine"]

    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


# ------------------------------------------------------------------
# Action handlers — Replication Groups
# ------------------------------------------------------------------


async def _handle_create_replication_group(state: _ElastiCacheState, body: dict) -> Response:
    rg_id = body.get("ReplicationGroupId", "")
    if not rg_id:
        return _error_response(
            "InvalidParameterValue",
            "ReplicationGroupId is required.",
        )

    if rg_id in state.replication_groups:
        return _error_response(
            "ReplicationGroupAlreadyExists",
            f"Replication group {rg_id} already exists.",
        )

    description = body.get("ReplicationGroupDescription", "")
    member_clusters = body.get("MemberClusters", [])
    tags_list = body.get("Tags", [])
    tags = {t["Key"]: t["Value"] for t in tags_list} if tags_list else {}

    rg = _ReplicationGroup(
        replication_group_id=rg_id,
        description=description,
        member_clusters=member_clusters,
        tags=tags,
    )
    state.replication_groups[rg_id] = rg

    return _json_response({"ReplicationGroup": _format_replication_group(rg)})


async def _handle_describe_replication_groups(state: _ElastiCacheState, body: dict) -> Response:
    rg_id = body.get("ReplicationGroupId")

    if rg_id:
        rg = state.replication_groups.get(rg_id)
        if rg is None:
            return _error_response(
                "ReplicationGroupNotFoundFault",
                f"Replication group {rg_id} not found.",
            )
        return _json_response({"ReplicationGroups": [_format_replication_group(rg)]})

    groups = [_format_replication_group(rg) for rg in state.replication_groups.values()]
    return _json_response({"ReplicationGroups": groups})


async def _handle_delete_replication_group(state: _ElastiCacheState, body: dict) -> Response:
    rg_id = body.get("ReplicationGroupId", "")
    rg = state.replication_groups.get(rg_id)
    if rg is None:
        return _error_response(
            "ReplicationGroupNotFoundFault",
            f"Replication group {rg_id} not found.",
        )

    del state.replication_groups[rg_id]
    rg.status = "deleted"
    return _json_response({"ReplicationGroup": _format_replication_group(rg)})


# ------------------------------------------------------------------
# Action handlers — Tags
# ------------------------------------------------------------------


async def _handle_list_tags_for_resource(state: _ElastiCacheState, body: dict) -> Response:
    resource_arn = body.get("ResourceName", "")
    tags = _find_tags_by_arn(state, resource_arn)
    if tags is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Resource {resource_arn} not found.",
        )
    tag_list = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_add_tags_to_resource(state: _ElastiCacheState, body: dict) -> Response:
    resource_arn = body.get("ResourceName", "")
    tags_list = body.get("Tags", [])

    tags = _find_tags_by_arn(state, resource_arn)
    if tags is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Resource {resource_arn} not found.",
        )

    for tag in tags_list:
        tags[tag["Key"]] = tag["Value"]

    result_tags = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": result_tags})


async def _handle_remove_tags_from_resource(state: _ElastiCacheState, body: dict) -> Response:
    resource_arn = body.get("ResourceName", "")
    tag_keys = body.get("TagKeys", [])

    tags = _find_tags_by_arn(state, resource_arn)
    if tags is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Resource {resource_arn} not found.",
        )

    for key in tag_keys:
        tags.pop(key, None)

    result_tags = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": result_tags})


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _find_tags_by_arn(state: _ElastiCacheState, arn: str) -> dict[str, str] | None:
    """Find the tags dict for a resource by ARN."""
    for cluster in state.clusters.values():
        if cluster.arn == arn:
            return cluster.tags
    for rg in state.replication_groups.values():
        if rg.arn == arn:
            return rg.tags
    return None


def _format_cache_cluster(cluster: _CacheCluster) -> dict[str, Any]:
    """Format a cache cluster for API response."""
    return {
        "CacheClusterId": cluster.cache_cluster_id,
        "Engine": cluster.engine,
        "NumCacheNodes": cluster.num_cache_nodes,
        "CacheNodeType": cluster.cache_node_type,
        "CacheClusterStatus": cluster.status,
        "ARN": cluster.arn,
        "ConfigurationEndpoint": cluster.endpoint,
        "CacheClusterCreateTime": cluster.created_date,
    }


def _format_replication_group(rg: _ReplicationGroup) -> dict[str, Any]:
    """Format a replication group for API response."""
    return {
        "ReplicationGroupId": rg.replication_group_id,
        "Description": rg.description,
        "Status": rg.status,
        "MemberClusters": rg.member_clusters,
        "ARN": rg.arn,
    }


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in ElastiCache format (lowercase 'message' key)."""
    return _error_response_base(code, message, status_code=status_code, message_key="message")


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateCacheCluster": _handle_create_cache_cluster,
    "DescribeCacheClusters": _handle_describe_cache_clusters,
    "DeleteCacheCluster": _handle_delete_cache_cluster,
    "ModifyCacheCluster": _handle_modify_cache_cluster,
    "CreateReplicationGroup": _handle_create_replication_group,
    "DescribeReplicationGroups": _handle_describe_replication_groups,
    "DeleteReplicationGroup": _handle_delete_replication_group,
    "ListTagsForResource": _handle_list_tags_for_resource,
    "AddTagsToResource": _handle_add_tags_to_resource,
    "RemoveTagsFromResource": _handle_remove_tags_from_resource,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_elasticache_app() -> FastAPI:
    """Create a FastAPI application that speaks the ElastiCache wire protocol."""
    app = FastAPI(title="LDK ElastiCache")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="elasticache")
    state = _ElastiCacheState()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown ElastiCache action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: ElastiCache operation '{action}' is not yet implemented",
            )

        return await handler(state, body)

    return app
