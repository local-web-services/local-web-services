"""Then: the "memorydb" "user" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@then('the "memorydb" "user" will be in "CREATING" state')
def user_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected user creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeUsers"},
        json={"UserName": INT_USER_NAME},
    )
    users = r.json().get("Users", [])
    assert users, f"Expected user '{INT_USER_NAME}' to exist but found none"
    expected_statuses = ("active", "creating")
    actual_status = users[0]["Status"]
    assert (
        actual_status in expected_statuses
    ), f"Expected user status in {expected_statuses} but got: {actual_status}"
