"""When: an automatic failover promotes a new primary in a "elasticache" "replication group" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when('an automatic failover promotes a new primary in a "elasticache" "replication group"')
def failover_replication_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.TestFailover"},
        json={"ReplicationGroupId": INT_RG_ID, "NodeGroupId": "0001"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
