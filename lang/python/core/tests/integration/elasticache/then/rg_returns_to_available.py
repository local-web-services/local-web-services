"""Then: the "elasticache" "replication group" returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@then('the "elasticache" "replication group" returns to "AVAILABLE" state')
def rg_returns_to_available(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeReplicationGroups"},
        json={"ReplicationGroupId": INT_RG_ID},
    )
    rgs = r.json().get("ReplicationGroups", [])
    assert rgs, f"Expected replication group '{INT_RG_ID}' to exist but found none"
    expected_status = "available"
    actual_status = rgs[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected replication group status '{expected_status}' but got: {actual_status}"
