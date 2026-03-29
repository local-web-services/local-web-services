"""When: a database cluster snapshot is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when("a database cluster snapshot is deleted")
def delete_db_cluster_snapshot(lws_session, world):
    try:
        snapshot_id = world.get("snapshot_id", TEST_SNAPSHOT)
        result = lws_session.client("neptune").delete_db_cluster_snapshot(
            DBClusterSnapshotIdentifier=snapshot_id
        )
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
