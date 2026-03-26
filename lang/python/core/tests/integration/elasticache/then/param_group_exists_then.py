"""Then: the parameter group exists"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_PARAM_GROUP_ID


@then("the parameter group exists")
def param_group_exists_then(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected parameter group creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheParameterGroups"},
        json={"CacheParameterGroupName": INT_PARAM_GROUP_ID},
    )
    pgs = r.json().get("CacheParameterGroups", [])
    assert pgs, f"Expected parameter group '{INT_PARAM_GROUP_ID}' to exist but found none"
