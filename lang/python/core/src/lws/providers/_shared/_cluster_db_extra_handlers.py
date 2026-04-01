"""Additional cluster-DB action handlers: snapshots, modify, reboot.

These handlers are factored out of cluster_db_service.py to keep that
file below the project's 500-line limit.
"""

from __future__ import annotations

from typing import Any

from fastapi import Response

from lws.providers._shared._cluster_db_state import (
    _apply_tags,
    _cluster_available_guard,
    _cluster_not_found_guard,
    _ClusterDBState,
    _DBCluster,
    _DBClusterSnapshot,
    _describe_cluster,
    _describe_instance,
    _describe_snapshot,
)
from lws.providers._shared.aws_capacity import check_capacity
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    apply_delete_lifecycle,
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


def _get_config_from_cluster_db_config(config):  # type: ignore[no-untyped-def]
    """Return config — kept as a typed-ignore helper to avoid circular imports."""
    return config


async def handle_create_db_cluster_snapshot(state: _ClusterDBState, body: dict, config) -> Response:
    """Create a DB cluster snapshot."""
    if config.capacity is not None:
        cap_err = check_capacity(config.capacity, "DBClusterSnapshotAlreadyExistsFault", 400)
        if cap_err is not None:
            return cap_err
    sid = body.get("DBClusterSnapshotIdentifier", "")
    cid = body.get("DBClusterIdentifier", "")
    if sid in state.snapshots:
        return _error_response(
            "DBClusterSnapshotAlreadyExistsFault",
            f"Snapshot {sid} already exists.",
        )
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    engine = cluster.engine  # type: ignore[union-attr]
    snapshot = _DBClusterSnapshot(
        snapshot_identifier=sid,
        cluster_identifier=cid,
        engine=engine,
        config=config,
    )
    _apply_tags(
        {k: k for k in []},
        body.get("Tags", []),
    )
    state.snapshots[sid] = snapshot
    return _json_response({"DBClusterSnapshot": _describe_snapshot(snapshot)})


async def handle_describe_db_cluster_snapshots(
    state: _ClusterDBState, body: dict, _config, *, snapshot_tracker=None
) -> Response:
    """Describe DB cluster snapshots."""
    sid = body.get("DBClusterSnapshotIdentifier")
    if sid:
        snapshot = state.snapshots.get(sid)
        if snapshot is None:
            return _error_response(
                "DBClusterSnapshotNotFoundFault",
                f"Snapshot {sid} not found.",
            )
        raw = _describe_snapshot(snapshot)
        if snapshot_tracker is not None:
            lc_state = snapshot_tracker.get_state(sid)
            if lc_state is not None:
                raw["Status"] = lc_state.lower()
        return _json_response({"DBClusterSnapshots": [raw]})
    snapshots = []
    for s in state.snapshots.values():
        raw = _describe_snapshot(s)
        if snapshot_tracker is not None:
            lc_state = snapshot_tracker.get_state(s.snapshot_identifier)
            if lc_state is not None:
                raw["Status"] = lc_state.lower()
        snapshots.append(raw)
    return _json_response({"DBClusterSnapshots": snapshots})


async def handle_delete_db_cluster_snapshot(
    state: _ClusterDBState, body: dict, _config
) -> Response:
    """Delete a DB cluster snapshot."""
    sid = body.get("DBClusterSnapshotIdentifier", "")
    snapshot = state.snapshots.pop(sid, None)
    if snapshot is None:
        return _error_response(
            "DBClusterSnapshotNotFoundFault",
            f"Snapshot {sid} not found.",
        )
    snapshot.status = "deleted"
    return _json_response({"DBClusterSnapshot": _describe_snapshot(snapshot)})


async def handle_restore_db_cluster_from_snapshot(
    state: _ClusterDBState, body: dict, config
) -> Response:
    """Restore a DB cluster from a snapshot."""
    if config.capacity is not None:
        cap_err = check_capacity(config.capacity, "DBClusterAlreadyExistsFault", 400)
        if cap_err is not None:
            return cap_err
    cid = body.get("DBClusterIdentifier", "")
    sid = body.get("SnapshotIdentifier", "")
    if cid in state.clusters:
        return _error_response(
            "DBClusterAlreadyExistsFault",
            f"Cluster {cid} already exists.",
        )
    snapshot = state.snapshots.get(sid)
    if snapshot is None:
        return _error_response(
            "DBClusterSnapshotNotFoundFault",
            f"Snapshot {sid} not found.",
        )
    engine = snapshot.engine
    cluster = _DBCluster(
        db_cluster_identifier=cid,
        engine=engine,
        master_username="",
        config=config,
        initial_status="restoring",
    )
    state.clusters[cid] = cluster
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def handle_stop_db_cluster(state: _ClusterDBState, body: dict, config) -> Response:
    """Stop a DB cluster."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    cluster.status = "stopping"  # type: ignore[union-attr]
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def handle_start_db_cluster(state: _ClusterDBState, body: dict, config) -> Response:
    """Start a DB cluster."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_not_found_guard(cid, cluster)
    if guard is not None:
        return guard
    if cluster.status != "stopped":  # type: ignore[union-attr]
        return _error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} is not in stopped state.",
        )
    cluster.status = "available"  # type: ignore[union-attr]
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def handle_failover_db_cluster(state: _ClusterDBState, body: dict, config) -> Response:
    """Failover a DB cluster."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    if not cluster.multi_az:  # type: ignore[union-attr]
        return _error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} does not have multi-AZ enabled.",
        )
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def handle_modify_db_cluster(state: _ClusterDBState, body: dict, config) -> Response:
    """Modify a DB cluster configuration."""
    cid = body.get("DBClusterIdentifier", "")
    cluster = state.clusters.get(cid)
    guard = _cluster_available_guard(cid, cluster)
    if guard is not None:
        return guard
    cluster.status = "modifying"  # type: ignore[union-attr]
    return _json_response({"DBCluster": _describe_cluster(cluster, config)})


async def handle_reboot_db_instance(state: _ClusterDBState, body: dict, _config) -> Response:
    """Reboot a DB instance."""
    iid = body.get("DBInstanceIdentifier", "")
    instance = state.instances.get(iid)
    if instance is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Instance {iid} not found.",
        )
    if instance.status != "available":
        return _error_response(
            "InvalidDBInstanceStateFault",
            f"Instance {iid} is not in available state.",
        )
    cid = instance.db_cluster_identifier
    cluster = state.clusters.get(cid)
    if cluster is None:
        return _error_response(
            "DBClusterNotFoundFault",
            f"Cluster {cid} not found.",
        )
    if cluster.status != "available":
        return _error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} is not in available state.",
        )
    return _json_response({"DBInstance": _describe_instance(instance)})


async def handle_modify_db_instance(state: _ClusterDBState, body: dict, _config) -> Response:
    """Modify a DB instance configuration."""
    iid = body.get("DBInstanceIdentifier", "")
    instance = state.instances.get(iid)
    if instance is None:
        return _error_response(
            "DBInstanceNotFoundFault",
            f"Instance {iid} not found.",
        )
    if instance.status != "available":
        return _error_response(
            "InvalidDBInstanceStateFault",
            f"Instance {iid} is not in available state.",
        )
    cid = instance.db_cluster_identifier
    cluster = state.clusters.get(cid)
    if cluster is None:
        return _error_response(
            "DBClusterNotFoundFault",
            f"Cluster {cid} not found.",
        )
    if cluster.status != "available":
        return _error_response(
            "InvalidDBClusterStateFault",
            f"Cluster {cid} is not in available state.",
        )
    instance.status = "modifying"
    return _json_response({"DBInstance": _describe_instance(instance)})


async def lifecycle_create_snapshot(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke create-snapshot handler and register lifecycle CREATING state."""
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        sid = body.get("DBClusterSnapshotIdentifier", "")
        tracker.set_state(sid, "CREATING")
        tracker.schedule_transition(sid, "available", lc.create_dwell_ms)
    return resp


async def lifecycle_delete_snapshot(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Guard against deleting a creating snapshot and apply delete lifecycle."""
    sid = body.get("DBClusterSnapshotIdentifier", "")
    guard = _creating_guard(
        sid, "InvalidDBClusterSnapshotStateFault", "DB cluster snapshot", tracker.get_state(sid)
    )
    if guard is not None:
        return guard
    resp = await handler(state, body, config)
    return apply_delete_lifecycle(resp, sid, lc, tracker)


async def run_snapshot_lifecycle(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    action: str,
) -> Response | None:
    """Handle snapshot-specific lifecycle. Returns None to fall through."""
    if action == "CreateDBClusterSnapshot":
        return await lifecycle_create_snapshot(handler, state, body, config, lc, tracker)
    if action == "DeleteDBClusterSnapshot":
        return await lifecycle_delete_snapshot(handler, state, body, config, lc, tracker)
    if action == "DescribeDBClusterSnapshots":
        return await handler(state, body, config, snapshot_tracker=tracker)
    return None


async def lifecycle_create_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke create-cluster handler and register lifecycle CREATING state."""
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        cid = body.get("DBClusterIdentifier", "")
        tracker.set_state(cid, "CREATING")
        tracker.schedule_transition(cid, "available", lc.create_dwell_ms)
    return resp


async def lifecycle_delete_cluster(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Guard against deleting a creating cluster and apply delete lifecycle."""
    cid = body.get("DBClusterIdentifier", "")
    guard = _creating_guard(cid, "InvalidDBClusterStateFault", "DB cluster", tracker.get_state(cid))
    if guard is not None:
        return guard
    resp = await handler(state, body, config)
    return apply_delete_lifecycle(resp, cid, lc, tracker)


async def lifecycle_create_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Invoke create-instance handler and register lifecycle CREATING state."""
    resp = await handler(state, body, config)
    if resp.status_code == 200:
        iid = body.get("DBInstanceIdentifier", "")
        tracker.set_state(iid, "CREATING")
        tracker.schedule_transition(iid, "available", lc.create_dwell_ms)
    return resp


async def lifecycle_delete_instance(
    handler: Any,
    state: _ClusterDBState,
    body: dict,
    config: Any,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Guard against deleting a creating instance and apply delete lifecycle."""
    iid = body.get("DBInstanceIdentifier", "")
    guard = _creating_guard(
        iid, "InvalidDBInstanceStateFault", "DB instance", tracker.get_state(iid)
    )
    if guard is not None:
        return guard
    resp = await handler(state, body, config)
    return apply_delete_lifecycle(resp, iid, lc, tracker)
