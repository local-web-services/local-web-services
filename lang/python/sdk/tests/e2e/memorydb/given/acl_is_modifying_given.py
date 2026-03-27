"""Given: the "ACL" is "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_ACL


@given('the "ACL" is "MODIFYING"')
def acl_is_modifying_given(lws_session, world):
    # Arrange
    acl_name = world.get("acl_name", TEST_ACL)
    # Act
    lws_session.inject_state("memorydb", "acl", acl_name, "modifying")
    # Assert
    world["acl_state"] = "modifying"
