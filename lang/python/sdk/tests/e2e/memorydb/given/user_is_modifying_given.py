"""Given: the "memorydb" "user" was "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_USER


@given('the "memorydb" "user" was "MODIFYING"')
def user_is_modifying_given(lws_session, world):
    # Arrange
    user_name = world.get("user_name", TEST_USER)
    # Act
    lws_session.inject_state("memorydb", "user", user_name, "modifying")
    # Assert
    world["user_state"] = "modifying"
