"""When: an "elasticache" subnet group is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_SUBNET_GROUP_ID


@when('an "elasticache" subnet group is deleted')
def delete_cache_subnet_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DeleteCacheSubnetGroup"},
        json={"CacheSubnetGroupName": INT_SUBNET_GROUP_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
