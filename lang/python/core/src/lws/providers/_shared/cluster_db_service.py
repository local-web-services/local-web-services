"""Shared cluster-DB factory for DocumentDB and Neptune providers.

Both services share nearly identical cluster/instance CRUD, tag management,
and response formatting logic.  This module parameterises the differences
via a config dataclass so each provider is a thin wrapper.
"""

from __future__ import annotations

from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared._cluster_db_config import ClusterDBConfig
from lws.providers._shared._cluster_db_dispatch import dispatch_request
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_create_db_cluster_snapshot as _handle_create_db_cluster_snapshot,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_delete_db_cluster_snapshot as _handle_delete_db_cluster_snapshot,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_describe_db_cluster_snapshots as _handle_describe_db_cluster_snapshots,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_failover_db_cluster as _handle_failover_db_cluster,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_modify_db_cluster as _handle_modify_db_cluster,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_modify_db_instance as _handle_modify_db_instance,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_reboot_db_instance as _handle_reboot_db_instance,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_restore_db_cluster_from_snapshot as _handle_restore_db_cluster_from_snapshot,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_start_db_cluster as _handle_start_db_cluster,
)
from lws.providers._shared._cluster_db_extra_handlers import (
    handle_stop_db_cluster as _handle_stop_db_cluster,
)
from lws.providers._shared._cluster_db_state import (
    _apply_tags,
    _cluster_available_guard,
    _ClusterDBState,
    _DBCluster,
    _DBInstance,
    _describe_cluster,
    _describe_instance,
    _find_tags_by_arn,
)
from lws.providers._shared.aws_capacity import check_capacity as _check_capacity
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
    apply_delete_lifecycle,
    register_tracker,
)
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


# ClusterDBConfig is defined in _cluster_db_config.py and re-exported here
# for backward-compatibility with existing imports.
__all__ = [
    "ClusterDBConfig",
    "create_cluster_db_app",
    "check_db_resource_read_lifecycle",
    "_ClusterDBState",
]


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
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    active_instances = [i for i in state.instances.values() if i.db_cluster_identifier == cid]
    if active_instances:
        return _error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} has non-deleted instances.",
        )
    state.clusters.pop(cid)
    cluster.status = "deleting"  # type: ignore[union-attr]
    if config.container_manager:
        await config.container_manager.stop_container(cid)
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def _handle_create_db_instance(
    state: _ClusterDBState, body: dict, config: ClusterDBConfig
) -> Response:
    if config.capacity is not None:
        cap_err = _check_capacity(config.capacity, "DBInstanceAlreadyExistsFault", 400)
        if cap_err is not None:
            return cap_err
    iid = body.get("DBInstanceIdentifier", "")
    if iid in state.instances:
        return _error_response(
            "DBInstanceAlreadyExistsFault",
            f"Instance {iid} already exists.",
        )

    cid = body.get("DBClusterIdentifier", "")
    endpoint = None
    if cid:
        cluster = state.clusters.get(cid)
        guard = _cluster_available_guard(cid, cluster)
        if guard is not None:
            return guard
        endpoint = cluster.endpoint  # type: ignore[union-attr]
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


def create_cluster_db_app(
    config: ClusterDBConfig,
    registry: TrackerRegistry | None = None,
) -> tuple[FastAPI, _ClusterDBState]:
    """Create a FastAPI app that speaks a cluster-DB wire protocol.

    Returns a tuple of (app, state) so the caller can register state for reset.
    """
    logger = get_logger(config.logger_name)
    _lc = config.lifecycle or ResourceLifecycleConfig()
    _cluster_tracker = ResourceStateTracker(_lc)
    _instance_tracker = ResourceStateTracker(_lc)
    if registry is not None:
        register_tracker(registry, config.service_name, "cluster", _cluster_tracker)
        register_tracker(registry, config.service_name, "instance", _instance_tracker)

    app = FastAPI(title=f"LDK {config.display_name}")
    app.add_middleware(RequestLoggingMiddleware, logger=logger, service_name=config.service_name)
    state = _ClusterDBState()

    action_handlers: dict[str, Any] = {
        "CreateDBCluster": _handle_create_db_cluster,
        "DescribeDBClusters": _handle_describe_db_clusters,
        "DeleteDBCluster": _handle_delete_db_cluster,
        "StopDBCluster": _handle_stop_db_cluster,
        "StartDBCluster": _handle_start_db_cluster,
        "FailoverDBCluster": _handle_failover_db_cluster,
        "ModifyDBCluster": _handle_modify_db_cluster,
        "CreateDBInstance": _handle_create_db_instance,
        "DescribeDBInstances": _handle_describe_db_instances,
        "DeleteDBInstance": _handle_delete_db_instance,
        "RebootDBInstance": _handle_reboot_db_instance,
        "ModifyDBInstance": _handle_modify_db_instance,
        "CreateDBClusterSnapshot": _handle_create_db_cluster_snapshot,
        "DescribeDBClusterSnapshots": _handle_describe_db_cluster_snapshots,
        "DeleteDBClusterSnapshot": _handle_delete_db_cluster_snapshot,
        "RestoreDBClusterFromSnapshot": _handle_restore_db_cluster_from_snapshot,
        "ListTagsForResource": _handle_list_tags,
        "AddTagsToResource": _handle_add_tags,
    }
    if config.include_remove_tags:
        action_handlers["RemoveTagsFromResource"] = _handle_remove_tags

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await dispatch_request(
            request,
            config,
            state,
            action_handlers,
            logger,
            _lc,
            _cluster_tracker,
            _instance_tracker,
            _check_cluster_read_lifecycle,
            _check_instance_read_lifecycle,
            _run_with_lifecycle,
        )

    return app, state


async def _run_with_lifecycle(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    cluster_tracker: ResourceStateTracker,
    instance_tracker: ResourceStateTracker,
    action: str,
) -> Response:
    """Run handler, applying lifecycle management for create/delete actions."""
    if action == "CreateDBCluster" and lc.enabled:
        return await _lifecycle_create_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "DeleteDBCluster" and lc.enabled:
        return await _lifecycle_delete_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "CreateDBInstance" and lc.enabled:
        return await _lifecycle_create_instance(handler, state, body, config, lc, instance_tracker)
    if action == "DeleteDBInstance" and lc.enabled:
        return await _lifecycle_delete_instance(handler, state, body, config, lc, instance_tracker)
    return await handler(state, body, config)
