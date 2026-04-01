"""Then: the "neptune" "INSTANCE" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_INSTANCE


@then('the "neptune" "INSTANCE" will be in "MODIFYING" state')
def instance_is_modifying_then(lws_session, world):
    # Arrange
    instance_id = world.get("instance_id", TEST_INSTANCE)
    expected_state = "modifying"
    # Act
    response = lws_session.client("neptune").describe_db_instances(DBInstanceIdentifier=instance_id)
    actual_state = response["DBInstances"][0]["DBInstanceStatus"]
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
