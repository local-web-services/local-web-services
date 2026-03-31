"""When: a replica creation in a "elasticache" "replication group" completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when('a replica creation in a "elasticache" "replication group" completes')
def replica_creation_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeReplicationGroups"},
        json={"ReplicationGroupId": INT_RG_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
