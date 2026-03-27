"""When: a cluster is restored from a snapshot"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@when("a cluster is restored from a snapshot")
def restore_db_cluster_from_snapshot(lws_session, world):
    try:
        snapshot_id = world.get("snapshot_id", TEST_SNAPSHOT)
        restored_cluster_id = world.get("restored_cluster_id", TEST_CLUSTER + "-restored")
        result = lws_session.client("neptune").restore_db_cluster_from_snapshot(
            DBClusterIdentifier=restored_cluster_id,
            SnapshotIdentifier=snapshot_id,
            Engine="neptune",
        )
        world["result"] = result
        world["restored_cluster_id"] = restored_cluster_id
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
