"""When: a "neptune" "cluster" neptune snapshot is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@when('a "neptune" "cluster" neptune snapshot is created')
def create_db_cluster_snapshot(lws_session, world):
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        snapshot_id = world.get("snapshot_id", TEST_SNAPSHOT)
        result = lws_session.client("neptune").create_db_cluster_snapshot(
            DBClusterSnapshotIdentifier=snapshot_id,
            DBClusterIdentifier=cluster_id,
        )
        world["result"] = result
        world["snapshot_id"] = snapshot_id
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
