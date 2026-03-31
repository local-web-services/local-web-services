"""When: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID, INT_SNAPSHOT_ID


@when('an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"')
def create_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateSnapshot"},
        json={"CacheClusterId": INT_CLUSTER_ID, "SnapshotName": INT_SNAPSHOT_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
