"""Then: the "memorydb" "user" will no longer be a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import then


@then('the "memorydb" "user" will no longer be a member of the "memorydb" "ACL"')
def user_not_member_of_acl_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user removal from ACL to succeed but got: {actual_error}"
