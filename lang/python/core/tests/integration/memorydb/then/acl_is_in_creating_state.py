"""Then: the "memorydb" "ACL" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME


@then('the "memorydb" "ACL" will be in "CREATING" state')
def acl_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected ACL creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeACLs"},
        json={"ACLName": INT_ACL_NAME},
    )
    acls = r.json().get("ACLs", [])
    assert acls, f"Expected ACL '{INT_ACL_NAME}' to exist but found none"
    expected_statuses = ("active", "creating")
    actual_status = acls[0]["Status"]
    assert (
        actual_status in expected_statuses
    ), f"Expected ACL status in {expected_statuses} but got: {actual_status}"
