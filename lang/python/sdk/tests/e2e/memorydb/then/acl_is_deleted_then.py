"""Then: the "ACL" is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "ACL" is "DELETED"')
def acl_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected ACL delete to succeed but got: {actual_error}"
