"""Then: the "elasticache" "replication group" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_REPLICATION_GROUP


@then('the "elasticache" "replication group" will be in "MODIFYING" state')
def rg_is_modifying_then(lws_session, world):
    # Arrange
    replication_group_id = world.get("replication_group_id", TEST_REPLICATION_GROUP)
    expected_state = "modifying"
    # Act
    actual_state = lws_session.get_injected_state(
        "elasticache", "replication_group", replication_group_id
    )
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
