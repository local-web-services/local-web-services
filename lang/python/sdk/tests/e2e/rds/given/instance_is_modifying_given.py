"""Given: the instance is "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('the instance is "MODIFYING"')
def instance_is_modifying_given(lws_session, world):
    # Arrange
    instance_id = world.get("instance_id", TEST_DB)
    # Act
    lws_session.inject_state("rds", "instance", instance_id, "modifying")
    # Assert
    world["instance_state"] = "modifying"
