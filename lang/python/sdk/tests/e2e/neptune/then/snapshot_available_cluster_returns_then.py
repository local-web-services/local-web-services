"""Then: the "neptune" "snapshot" will be "AVAILABLE" and the "neptune" "cluster" returns to "AVAILABLE" if it was backing up"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SNAPSHOT


@then(
    'the "neptune" "snapshot" will be "AVAILABLE" and the "neptune" "cluster" returns to "AVAILABLE" if it was backing up'
)
def snapshot_available_cluster_returns_then(lws_session, world):
    snapshot_id = world.get("snapshot_id", TEST_SNAPSHOT)
    response = lws_session.client("neptune").describe_db_cluster_snapshots(
        DBClusterSnapshotIdentifier=snapshot_id
    )
    actual_snapshots = response["DBClusterSnapshots"]
    expected_count = 1
    assert (
        len(actual_snapshots) == expected_count
    ), f"Expected {expected_count!r} snapshot but got {len(actual_snapshots)!r}"
    expected_status = "available"
    actual_status = actual_snapshots[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}"
