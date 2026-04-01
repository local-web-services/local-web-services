"""When: an "elasticache" "cluster" modification completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@when('an "elasticache" "cluster" modification completes')
def cache_cluster_modification_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
