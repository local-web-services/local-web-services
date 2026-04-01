"""Then: the "memorydb" "user" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_USER


@then('the "memorydb" "user" will be in "MODIFYING" state')
def user_is_modifying_then(lws_session, world):
    # Arrange
    user_name = world.get("user_name", TEST_USER)
    expected_state = "modifying"
    # Act
    actual_state = lws_session.get_injected_state("memorydb", "user", user_name)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
