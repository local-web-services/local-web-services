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
from lws.providers._shared._cluster_db_state import (
    _apply_tags,
    _ClusterDBState,
    _DBCluster,
    _DBInstance,
    _describe_cluster,
    _describe_instance,
    _find_tags_by_arn,
)
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    apply_delete_lifecycle,
)
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers._shared.resource_container import ResourceContainerManager
from lws.providers._shared.response_helpers import (
    creating_guard as _creating_guard,
)
from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)

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
    lifecycle: ResourceLifecycleConfig | None = None


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
    if config.container_manager:
        await config.container_manager.stop_container(cid)
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

    cid = body.get("DBClusterIdentifier", "")
    endpoint = None
    if cid and cid in state.clusters:
        endpoint = state.clusters[cid].endpoint
    instance = _DBInstance(
        db_instance_identifier=iid,
        db_instance_class=body.get("DBInstanceClass", config.default_instance_class),
        engine=body.get("Engine", config.default_engine),
        db_cluster_identifier=cid,
        config=config,
        data_plane_endpoint=endpoint,
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
# App factory helpers
# ------------------------------------------------------------------

_CLUSTER_READ_ACTIONS = {"DescribeDBClusters"}
_INSTANCE_READ_ACTIONS = {"DescribeDBInstances"}


def check_db_resource_read_lifecycle(
    action: str,
    body: dict,
    resource_id_key: str,
    fault_code: str,
    resource_type: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    read_actions: set,
) -> Response | None:
    """Guard a DB read action when the resource is not yet available."""
    if not lc.enabled or action not in read_actions:
        return None
    rid = body.get(resource_id_key, "")
    if not rid:
        return None
    state = tracker.get_state(rid)
    if state in ("CREATING", "DELETING"):
        return _error_response(
            fault_code,
            f"{resource_type} {rid} is not in an available state (status: {state})",
            status_code=400,
        )
    return None


def _check_cluster_read_lifecycle(
    action: str,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    key, fault, rtype = "DBClusterIdentifier", "InvalidDBClusterStateFault", "DB cluster"
    return check_db_resource_read_lifecycle(
        action, body, key, fault, rtype, lc, tracker, _CLUSTER_READ_ACTIONS
    )


def _check_instance_read_lifecycle(
    action: str,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    key, fault, rtype = "DBInstanceIdentifier", "InvalidDBInstanceStateFault", "DB instance"
    return check_db_resource_read_lifecycle(
        action, body, key, fault, rtype, lc, tracker, _INSTANCE_READ_ACTIONS
    )


async def _lifecycle_create_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        cid = body.get("DBClusterIdentifier", "")
        tracker.set_state(cid, "CREATING")
        tracker.schedule_transition(cid, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    cid = body.get("DBClusterIdentifier", "")
    guard = _creating_guard(cid, "InvalidDBClusterStateFault", "DB cluster", tracker.get_state(cid))
    if guard is not None:
        return guard
    resp = await handler(state, body, config)
    return apply_delete_lifecycle(resp, cid, lc, tracker)


async def _lifecycle_create_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        iid = body.get("DBInstanceIdentifier", "")
        tracker.set_state(iid, "CREATING")
        tracker.schedule_transition(iid, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    iid = body.get("DBInstanceIdentifier", "")
    guard = _creating_guard(
        iid, "InvalidDBInstanceStateFault", "DB instance", tracker.get_state(iid)
    )
    if guard is not None:
        return guard
    resp = await handler(state, body, config)
    return apply_delete_lifecycle(resp, iid, lc, tracker)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_cluster_db_app(config: ClusterDBConfig) -> FastAPI:
    """Create a FastAPI app that speaks a cluster-DB wire protocol."""
    logger = get_logger(config.logger_name)
    _lc = config.lifecycle or ResourceLifecycleConfig()
    _cluster_tracker = ResourceStateTracker(_lc)
    _instance_tracker = ResourceStateTracker(_lc)

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

        err = _check_cluster_read_lifecycle(action, body, _lc, _cluster_tracker)
        if err is not None:
            return err

        err = _check_instance_read_lifecycle(action, body, _lc, _instance_tracker)
        if err is not None:
            return err

        handler = action_handlers.get(action)
        if handler is None:
            logger.warning("Unknown %s action: %s", config.display_name, action)
            return _error_response(
                "InvalidAction",
                f"lws: {config.display_name} operation '{action}' is not yet implemented",
            )

        if action == "CreateDBCluster" and _lc.enabled and _lc.create_dwell_ms > 0:
            return await _lifecycle_create_cluster(
                handler, state, body, config, _lc, _cluster_tracker
            )

        if action == "DeleteDBCluster" and _lc.enabled:
            return await _lifecycle_delete_cluster(
                handler, state, body, config, _lc, _cluster_tracker
            )

        if action == "CreateDBInstance" and _lc.enabled and _lc.create_dwell_ms > 0:
            return await _lifecycle_create_instance(
                handler, state, body, config, _lc, _instance_tracker
            )

        if action == "DeleteDBInstance" and _lc.enabled:
            return await _lifecycle_delete_instance(
                handler, state, body, config, _lc, _instance_tracker
            )

        return await handler(state, body, config)

    return app
