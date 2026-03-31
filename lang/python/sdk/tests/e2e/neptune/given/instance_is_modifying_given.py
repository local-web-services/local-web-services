"""Given: the "neptune" "instance" was "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('the "neptune" "instance" was "MODIFYING"')
def instance_is_modifying_given(lws_session, world):
    # Arrange
    instance_id = world.get("instance_id", TEST_INSTANCE)
    # Act
    lws_session.inject_state("neptune", "instance", instance_id, "modifying")
    # Assert
    world["instance_state"] = "modifying"
