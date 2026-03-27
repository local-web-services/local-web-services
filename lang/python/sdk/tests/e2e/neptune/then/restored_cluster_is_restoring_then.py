"""Then: the restored cluster is in "RESTORING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the restored cluster is in "RESTORING" state')
def restored_cluster_is_restoring_then(lws_session, world):
    restored_cluster_id = world.get("restored_cluster_id", TEST_CLUSTER + "-restored")
    response = lws_session.client("neptune").describe_db_clusters(
        DBClusterIdentifier=restored_cluster_id
    )
    actual_clusters = response["DBClusters"]
    expected_count = 1
    assert (
        len(actual_clusters) == expected_count
    ), f"Expected {expected_count!r} cluster but got {len(actual_clusters)!r}"
