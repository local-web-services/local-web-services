"""ElastiCache HTTP routes.

Implements the ElastiCache wire protocol that AWS SDKs and Terraform use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
    register_tracker,
)
from lws.providers._shared.provider_context import ProviderContext
from lws.providers._shared.request_helpers import action_dispatch as _action_dispatch
from lws.providers._shared.resource_container import ResourceContainerManager
from lws.providers._shared.response_helpers import error_response as _error_response_base
from lws.providers._shared.response_helpers import json_response as _json_response
from lws.providers.elasticache._elasticache_state import (
    _CacheCluster,
    _ElastiCacheState,
    _ReplicationGroup,
)

_logger = get_logger("ldk.elasticache")


# ------------------------------------------------------------------
# Action handlers — Cache Clusters
# ------------------------------------------------------------------


async def _handle_create_cache_cluster(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
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

    endpoint = None
    if state.container_manager:
        endpoint = await state.container_manager.start_container(cluster_id)
    cluster = _CacheCluster(
        cache_cluster_id=cluster_id,
        engine=engine,
        num_cache_nodes=num_cache_nodes,
        cache_node_type=cache_node_type,
        tags=tags,
        data_plane_endpoint=endpoint,
    )
    state.clusters[cluster_id] = cluster

    lc = tracker.config
    if lc.enabled:
        tracker.set_state(cluster_id, "CREATING")
        tracker.schedule_transition(cluster_id, "ACTIVE", lc.create_dwell_ms)
        if lc.create_dwell_ms > 0:
            cluster.status = "creating"

    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


async def _handle_describe_cache_clusters(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
    cluster_id = body.get("CacheClusterId")

    if cluster_id:
        lc_state = tracker.get_state(cluster_id)
        if lc_state in ("CREATING", "DELETING"):
            return _error_response(
                "CacheClusterNotFound",
                f"Cache cluster {cluster_id} not found.",
            )
        cluster = state.clusters.get(cluster_id)
        if cluster is None:
            return _error_response(
                "CacheClusterNotFound",
                f"Cache cluster {cluster_id} not found.",
            )
        return _json_response({"CacheClusters": [_format_cache_cluster(cluster)]})

    clusters = [_format_cache_cluster(c) for c in state.clusters.values()]
    return _json_response({"CacheClusters": clusters})


async def _handle_delete_cache_cluster(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
    cluster_id = body.get("CacheClusterId", "")
    if tracker.get_state(cluster_id) == "CREATING":
        return _error_response(
            "InvalidCacheClusterState",
            f"Cache cluster {cluster_id} is still being created.",
        )
    cluster = state.clusters.get(cluster_id)
    if cluster is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Cache cluster {cluster_id} not found.",
        )

    del state.clusters[cluster_id]
    if state.container_manager:
        await state.container_manager.stop_container(cluster_id)

    lc = tracker.config
    if lc.enabled and lc.delete_dwell_ms > 0:
        cluster.status = "deleting"
        tracker.set_state(cluster_id, "DELETING")
        tracker.schedule_transition(cluster_id, None, lc.delete_dwell_ms)
    else:
        cluster.status = "deleted"
        tracker.remove(cluster_id)

    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


async def _handle_modify_cache_cluster(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
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

    lc = tracker.config
    if lc.enabled:
        tracker.set_state(cluster_id, "MODIFYING")
        if lc.modify_dwell_ms > 0:
            tracker.schedule_transition(cluster_id, "ACTIVE", lc.modify_dwell_ms)

    return _json_response({"CacheCluster": _format_cache_cluster(cluster)})


async def _handle_create_replication_group(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
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

    lc = tracker.config
    rg_tracker_key = f"rg:{rg_id}"
    if lc.enabled:
        tracker.set_state(rg_tracker_key, "CREATING")
        tracker.schedule_transition(rg_tracker_key, "ACTIVE", lc.create_dwell_ms)
        if lc.create_dwell_ms > 0:
            rg.status = "creating"

    return _json_response({"ReplicationGroup": _format_replication_group(rg)})


async def _handle_describe_replication_groups(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
    rg_id = body.get("ReplicationGroupId")

    if rg_id:
        lc_state = tracker.get_state(f"rg:{rg_id}")
        if lc_state in ("CREATING", "DELETING"):
            return _error_response(
                "ReplicationGroupNotFoundFault",
                f"Replication group {rg_id} not found.",
            )
        rg = state.replication_groups.get(rg_id)
        if rg is None:
            return _error_response(
                "ReplicationGroupNotFoundFault",
                f"Replication group {rg_id} not found.",
            )
        return _json_response({"ReplicationGroups": [_format_replication_group(rg)]})

    groups = [_format_replication_group(rg) for rg in state.replication_groups.values()]
    return _json_response({"ReplicationGroups": groups})


async def _handle_modify_replication_group(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
    rg_id = body.get("ReplicationGroupId", "")
    rg = state.replication_groups.get(rg_id)
    if rg is None:
        return _error_response(
            "ReplicationGroupNotFoundFault",
            f"Replication group {rg_id} not found.",
        )

    if "ReplicationGroupDescription" in body:
        rg.description = body["ReplicationGroupDescription"]
    if "NotificationTopicArn" in body:
        rg.notification_topic_arn = body["NotificationTopicArn"]

    lc = tracker.config
    rg_tracker_key = f"rg:{rg_id}"
    if lc.enabled:
        tracker.set_state(rg_tracker_key, "MODIFYING")
        if lc.modify_dwell_ms > 0:
            tracker.schedule_transition(rg_tracker_key, "ACTIVE", lc.modify_dwell_ms)

    return _json_response({"ReplicationGroup": _format_replication_group(rg)})


async def _handle_delete_replication_group(
    state: _ElastiCacheState, body: dict, tracker: ResourceStateTracker
) -> Response:
    rg_id = body.get("ReplicationGroupId", "")
    rg_tracker_key = f"rg:{rg_id}"
    if tracker.get_state(rg_tracker_key) == "CREATING":
        return _error_response(
            "InvalidReplicationGroupState",
            f"Replication group {rg_id} is still being created.",
        )
    rg = state.replication_groups.get(rg_id)
    if rg is None:
        return _error_response(
            "ReplicationGroupNotFoundFault",
            f"Replication group {rg_id} not found.",
        )

    del state.replication_groups[rg_id]

    lc = tracker.config
    if lc.enabled and lc.delete_dwell_ms > 0:
        rg.status = "deleting"
        tracker.set_state(rg_tracker_key, "DELETING")
        tracker.schedule_transition(rg_tracker_key, None, lc.delete_dwell_ms)
    else:
        rg.status = "deleted"
        tracker.remove(rg_tracker_key)

    return _json_response({"ReplicationGroup": _format_replication_group(rg)})


# ------------------------------------------------------------------
# Action handlers — Tags
# ------------------------------------------------------------------


async def _handle_list_tags_for_resource(
    state: _ElastiCacheState, body: dict, _tracker: ResourceStateTracker
) -> Response:
    resource_arn = body.get("ResourceName", "")
    tags = _find_tags_by_arn(state, resource_arn)
    if tags is None:
        return _error_response(
            "CacheClusterNotFound",
            f"Resource {resource_arn} not found.",
        )
    tag_list = [{"Key": k, "Value": v} for k, v in tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_add_tags_to_resource(
    state: _ElastiCacheState, body: dict, _tracker: ResourceStateTracker
) -> Response:
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


async def _handle_remove_tags_from_resource(
    state: _ElastiCacheState, body: dict, _tracker: ResourceStateTracker
) -> Response:
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
    "ModifyReplicationGroup": _handle_modify_replication_group,
    "DeleteReplicationGroup": _handle_delete_replication_group,
    "ListTagsForResource": _handle_list_tags_for_resource,
    "AddTagsToResource": _handle_add_tags_to_resource,
    "RemoveTagsFromResource": _handle_remove_tags_from_resource,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_elasticache_app(
    *,
    container_manager: ResourceContainerManager | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    registry: TrackerRegistry | None = None,
    context: ProviderContext | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the ElastiCache wire protocol."""
    app = FastAPI(title="LDK ElastiCache")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="elasticache")
    state = _ElastiCacheState(container_manager=container_manager)
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)
    if registry is not None:
        register_tracker(registry, "elasticache", "cluster", _tracker)
        register_tracker(registry, "elasticache", "replication-group", _tracker)
        register_tracker(registry, "elasticache", "snapshot", _tracker)

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _action_dispatch(
            request, state, _tracker, _ACTION_HANDLERS, "ElastiCache", _logger, _error_response
        )

    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "elasticache")
    return app
