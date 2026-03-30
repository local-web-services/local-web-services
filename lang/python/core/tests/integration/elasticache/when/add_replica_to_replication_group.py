"""When: a replica is added to a replication group"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when("a replica is added to a replication group")
def add_replica_to_replication_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.IncreaseReplicaCount"},
        json={"ReplicationGroupId": INT_RG_ID, "ApplyImmediately": True},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
