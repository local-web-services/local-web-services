"""When: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME


@when('a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"')
def trigger_shard_failover(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.FailoverShard"},
        json={"ClusterName": INT_CLUSTER_NAME, "ShardConfiguration": {}},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
