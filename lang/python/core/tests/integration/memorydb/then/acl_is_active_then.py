"""Then: the "memorydb" "ACL" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME


@then('the "memorydb" "ACL" will be "ACTIVE"')
def acl_is_active_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeACLs"},
        json={"ACLName": INT_ACL_NAME},
    )
    acls = r.json().get("ACLs", [])
    assert acls, f"Expected ACL '{INT_ACL_NAME}' to exist but found none"
    expected_status = "active"
    actual_status = acls[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected ACL status '{expected_status}' but got: {actual_status}"
