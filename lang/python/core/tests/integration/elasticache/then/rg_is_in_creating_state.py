"""Then: the "elasticache" "replication group" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@then('the "elasticache" "replication group" will be in "CREATING" state')
def rg_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected replication group creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeReplicationGroups"},
        json={"ReplicationGroupId": INT_RG_ID},
    )
    rgs = r.json().get("ReplicationGroups", [])
    assert rgs, f"Expected replication group '{INT_RG_ID}' to exist but found none"
    expected_statuses = ("available", "creating")
    actual_status = rgs[0]["Status"]
    assert (
        actual_status in expected_statuses
    ), f"Expected replication group status in {expected_statuses} but got: {actual_status}"
