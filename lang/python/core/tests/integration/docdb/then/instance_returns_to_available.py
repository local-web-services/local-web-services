"""Then: the "documentdb" "instance" returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_INSTANCE_ID


@then('the "documentdb" "instance" returns to "AVAILABLE" state')
def instance_returns_to_available(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBInstances"},
        json={"DBInstanceIdentifier": INT_INSTANCE_ID},
    )
    instances = r.json().get("DBInstances", [])
    assert instances, f"Expected instance '{INT_INSTANCE_ID}' to exist but found none"
    expected_status = "available"
    actual_status = instances[0]["DBInstanceStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected instance status '{expected_status}' but got: {actual_status}"
