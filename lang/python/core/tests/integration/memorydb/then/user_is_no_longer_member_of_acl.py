"""Then: the user is no longer a member of the "ACL" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the user is no longer a member of the "ACL"')
def user_is_no_longer_member_of_acl(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected user to be removed from ACL but got: {actual_error}"
