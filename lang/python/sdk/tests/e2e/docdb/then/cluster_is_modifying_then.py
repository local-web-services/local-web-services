"""Then: the "documentdb" "cluster" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the "documentdb" "cluster" will be in "MODIFYING" state')
def cluster_is_modifying_then(lws_session, world):
    # Arrange
    cluster_id = world.get("cluster_id", TEST_CLUSTER)
    expected_state = "modifying"
    # Act
    actual_state = lws_session.get_injected_state("docdb", "cluster", cluster_id)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
