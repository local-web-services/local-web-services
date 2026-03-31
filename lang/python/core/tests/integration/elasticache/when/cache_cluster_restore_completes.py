"""When: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@when('an "elasticache" "cluster" restore from "elasticache" "snapshot" completes')
def cache_cluster_restore_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": f"{INT_CLUSTER_ID}-restored"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
