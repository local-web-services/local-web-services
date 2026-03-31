"""Lifecycle action runner helpers for cluster-DB providers.

These runner functions orchestrate which lifecycle wrapper to invoke for each
API action. Factored out of cluster_db_service.py to keep that file under the
500-line project limit.
"""

from __future__ import annotations

from typing import Any

from fastapi import Response

from lws.providers._shared._cluster_db_config import ClusterDBConfig
from lws.providers._shared._cluster_db_extra_handlers import (
    lifecycle_create_cluster,
    lifecycle_create_instance,
    lifecycle_delete_cluster,
    lifecycle_delete_instance,
    run_snapshot_lifecycle,
)
from lws.providers._shared._cluster_db_state import (
    _cluster_available_guard,
    _cluster_not_found_guard,
    _ClusterDBState,
    _describe_cluster,
)
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    apply_modify_lifecycle,
)
from lws.providers._shared.response_helpers import error_response, json_response


async def lifecycle_stop_cluster(
    _handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Validate cluster is available and apply STOPPING → stopped lifecycle."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    current = tracker.get_state(cid)
    if current is not None and current.lower() != "available":
        return error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} is not in available state.",
        )
    if lc.modify_dwell_ms > 0:
        tracker.set_state(cid, "STOPPING")
        tracker.schedule_transition(cid, "stopped", lc.modify_dwell_ms)
        cluster.status = "stopping"  # type: ignore[union-attr]
    else:
        tracker.set_state(cid, "stopped")
        cluster.status = "stopped"  # type: ignore[union-attr]
    raw = _describe_cluster(cluster, config)
    raw["Status"] = (tracker.get_state(cid) or "stopped").lower()
    return json_response({"DBCluster": raw})


async def lifecycle_start_cluster(
    _handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Validate cluster is stopped (via tracker) and apply STARTING → available lifecycle."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_not_found_guard(cid, cluster)
    if guard is not None:
        return guard
    current = tracker.get_state(cid)
    if current is None or current.lower() != "stopped":
        return error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} is not in stopped state.",
        )
    if lc.modify_dwell_ms > 0:
        tracker.set_state(cid, "STARTING")
        tracker.schedule_transition(cid, "available", lc.modify_dwell_ms)
        cluster.status = "starting"  # type: ignore[union-attr]
    else:
        tracker.set_state(cid, "available")
        cluster.status = "available"  # type: ignore[union-attr]
    raw = _describe_cluster(cluster, config)
    raw["Status"] = (tracker.get_state(cid) or "available").lower()
    return json_response({"DBCluster": raw})


async def lifecycle_restore_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke restore-cluster handler and apply RESTORING → available lifecycle."""
    cid = body.get("DBClusterIdentifier", "")
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        return apply_modify_lifecycle(
            resp, cid, lc, tracker, active_state="available", modifying_state="RESTORING"
        )
    return resp


async def lifecycle_failover_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke failover-cluster handler and apply FAILING_OVER → available lifecycle."""
    cid = body.get("DBClusterIdentifier", "")
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        return apply_modify_lifecycle(
            resp, cid, lc, tracker, active_state="available", modifying_state="FAILING_OVER"
        )
    return resp


async def lifecycle_modify_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke modify-cluster handler and register MODIFYING state in tracker."""
    cid = body.get("DBClusterIdentifier", "")
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        tracker.set_state(cid, "MODIFYING")
        if lc.modify_dwell_ms > 0:
            tracker.schedule_transition(cid, "available", lc.modify_dwell_ms)
    return resp


async def lifecycle_modify_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke modify-instance handler and register MODIFYING state in tracker."""
    iid = body.get("DBInstanceIdentifier", "")
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        tracker.set_state(iid, "MODIFYING")
        if lc.modify_dwell_ms > 0:
            tracker.schedule_transition(iid, "available", lc.modify_dwell_ms)
    return resp


async def lifecycle_reboot_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke reboot-instance handler and apply REBOOTING → available lifecycle."""
    iid = body.get("DBInstanceIdentifier", "")
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        return apply_modify_lifecycle(
            resp, iid, lc, tracker, active_state="available", modifying_state="REBOOTING"
        )
    return resp


async def run_cluster_lifecycle_action(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    cluster_tracker: ResourceStateTracker,
    action: str,
) -> Response | None:
    """Handle cluster lifecycle actions. Returns None to fall through."""
    if action == "DescribeDBClusters":
        return await handler(state, body, config, cluster_tracker=cluster_tracker)
    if action == "CreateDBCluster":
        return await lifecycle_create_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "DeleteDBCluster":
        return await lifecycle_delete_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "StopDBCluster":
        return await lifecycle_stop_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "StartDBCluster":
        return await lifecycle_start_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "RestoreDBClusterFromSnapshot":
        return await lifecycle_restore_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "FailoverDBCluster":
        return await lifecycle_failover_cluster(handler, state, body, config, lc, cluster_tracker)
    if action == "ModifyDBCluster":
        return await lifecycle_modify_cluster(handler, state, body, config, lc, cluster_tracker)
    return None


async def run_instance_lifecycle_action(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    instance_tracker: ResourceStateTracker,
    action: str,
) -> Response | None:
    """Handle instance lifecycle actions. Returns None to fall through."""
    if action == "DescribeDBInstances":
        return await handler(state, body, config, instance_tracker=instance_tracker)
    if action == "CreateDBInstance":
        return await lifecycle_create_instance(handler, state, body, config, lc, instance_tracker)
    if action == "DeleteDBInstance":
        return await lifecycle_delete_instance(handler, state, body, config, lc, instance_tracker)
    if action == "RebootDBInstance":
        return await lifecycle_reboot_instance(handler, state, body, config, lc, instance_tracker)
    if action == "ModifyDBInstance":
        return await lifecycle_modify_instance(handler, state, body, config, lc, instance_tracker)
    return None


async def run_cluster_instance_lifecycle(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    cluster_tracker: ResourceStateTracker,
    instance_tracker: ResourceStateTracker,
    action: str,
) -> Response | None:
    """Handle cluster/instance lifecycle. Returns None to fall through."""
    resp = await run_cluster_lifecycle_action(
        handler, state, body, config, lc, cluster_tracker, action
    )
    if resp is not None:
        return resp
    return await run_instance_lifecycle_action(
        handler, state, body, config, lc, instance_tracker, action
    )


async def run_with_lifecycle(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: ClusterDBConfig,
    lc: ResourceLifecycleConfig,
    cluster_tracker: ResourceStateTracker,
    instance_tracker: ResourceStateTracker,
    snapshot_tracker: ResourceStateTracker,
    action: str,
) -> Response:
    """Run handler, applying lifecycle management for create/delete actions."""
    if lc.enabled:
        resp = await run_cluster_instance_lifecycle(
            handler, state, body, config, lc, cluster_tracker, instance_tracker, action
        )
        if resp is not None:
            return resp
        snap_resp = await run_snapshot_lifecycle(
            handler, state, body, config, lc, snapshot_tracker, action
        )
        if snap_resp is not None:
            return snap_resp
    return await handler(state, body, config)
