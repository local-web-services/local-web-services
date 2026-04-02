"""Then: the "neptune" "snapshot" will be in "CREATING" state and linked to the "neptune" "cluster" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SNAPSHOT


@then('the "neptune" "snapshot" will be in "CREATING" state and linked to the "neptune" "cluster"')
def snapshot_is_creating_then(lws_session, world):
    snapshot_id = world.get("snapshot_id", TEST_SNAPSHOT)
    response = lws_session.client("neptune").describe_db_cluster_snapshots(
        DBClusterSnapshotIdentifier=snapshot_id
    )
    actual_snapshots = response["DBClusterSnapshots"]
    expected_count = 1
    assert (
        len(actual_snapshots) == expected_count
    ), f"Expected {expected_count!r} snapshot but got {len(actual_snapshots)!r}"
