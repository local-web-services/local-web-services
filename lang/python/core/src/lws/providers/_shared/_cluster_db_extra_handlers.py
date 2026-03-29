"""Additional cluster-DB action handlers: snapshots, modify, reboot.

These handlers are factored out of cluster_db_service.py to keep that
file below the project's 500-line limit.
"""

from __future__ import annotations

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
    state: _ClusterDBState, body: dict, _config
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
        return _json_response({"DBClusterSnapshots": [_describe_snapshot(snapshot)]})
    snapshots = [_describe_snapshot(s) for s in state.snapshots.values()]
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
    cluster.status = "stopped"  # type: ignore[union-attr]
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
