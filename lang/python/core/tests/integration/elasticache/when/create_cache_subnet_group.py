"""When: a cache subnet group is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_SUBNET_GROUP_ID


@when("a cache subnet group is created")
def create_cache_subnet_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheSubnetGroup"},
        json={
            "CacheSubnetGroupName": INT_SUBNET_GROUP_ID,
            "CacheSubnetGroupDescription": "int-test-sg",
            "SubnetIds": ["subnet-00000001"],
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
