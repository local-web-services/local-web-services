"""When: an "elasticache" "cluster" configuration is modified"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@when('an "elasticache" "cluster" configuration is modified')
def modify_cache_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.ModifyCacheCluster"},
        json={"CacheClusterId": INT_CLUSTER_ID, "ApplyImmediately": True},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
