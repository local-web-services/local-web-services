"""Then: the cluster is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session, world):
    expected_status = "available"
    cluster_id = world.get("cluster_id", TEST_CLUSTER)
    response = lws_session.client("neptune").describe_db_clusters(DBClusterIdentifier=cluster_id)
    actual_status = response["DBClusters"][0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}"
