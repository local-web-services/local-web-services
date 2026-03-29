"""Then: the "ACL" is in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ACL


@then('the "ACL" is in "MODIFYING" state')
def acl_is_modifying_then(lws_session, world):
    # Arrange
    acl_name = world.get("acl_name", TEST_ACL)
    expected_state = "modifying"
    # Act
    actual_state = lws_session.get_injected_state("memorydb", "acl", acl_name)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
