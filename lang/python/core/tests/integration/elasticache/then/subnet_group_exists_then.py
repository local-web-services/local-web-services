"""Then: the subnet group exists"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_SUBNET_GROUP_ID


@then("the subnet group exists")
def subnet_group_exists_then(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected subnet group creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheSubnetGroups"},
        json={"CacheSubnetGroupName": INT_SUBNET_GROUP_ID},
    )
    sgs = r.json().get("CacheSubnetGroups", [])
    assert sgs, f"Expected subnet group '{INT_SUBNET_GROUP_ID}' to exist but found none"
