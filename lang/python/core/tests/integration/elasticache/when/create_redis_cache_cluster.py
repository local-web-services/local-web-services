"""When: a redis cache cluster is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@when("a redis cache cluster is created")
def create_redis_cache_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheCluster"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
