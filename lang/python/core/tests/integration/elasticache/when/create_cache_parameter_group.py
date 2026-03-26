"""When: a cache parameter group is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_PARAM_GROUP_ID


@when("a cache parameter group is created")
def create_cache_parameter_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheParameterGroup"},
        json={
            "CacheParameterGroupName": INT_PARAM_GROUP_ID,
            "CacheParameterGroupFamily": "redis6.x",
            "Description": "int-test-pg",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
