"""Then: the "memorydb" "user" was a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "memorydb" "user" was a member of the "memorydb" "ACL"')
def user_is_member_of_acl_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected user to be added to ACL but got: {actual_error}"
