"""Then: the "neptune" "cluster" will be in "STOPPING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the "neptune" "cluster" will be in "STOPPING" state')
def cluster_is_stopping_then(lws_session, world):
    # Arrange
    cluster_id = world.get("cluster_id", TEST_CLUSTER)
    expected_state = "stopping"
    # Act
    response = lws_session.client("neptune").describe_db_clusters(DBClusterIdentifier=cluster_id)
    actual_state = response["DBClusters"][0]["Status"]
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
