"""When: an "elasticache" "cluster" is created from an "elasticache" "snapshot" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID, INT_SNAPSHOT_ID


@when('an "elasticache" "cluster" is created from an "elasticache" "snapshot"')
def create_cache_cluster_from_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateCacheCluster"},
        json={
            "CacheClusterId": f"{INT_CLUSTER_ID}-restored",
            "SnapshotName": INT_SNAPSHOT_ID,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
