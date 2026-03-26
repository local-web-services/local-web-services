"""Then: the user returns to "ACTIVE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@then('the user returns to "ACTIVE" state')
def user_returns_to_active(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeUsers"},
        json={"UserName": INT_USER_NAME},
    )
    users = r.json().get("Users", [])
    assert users, f"Expected user '{INT_USER_NAME}' to exist but found none"
    expected_status = "active"
    actual_status = users[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got: {actual_status}"
