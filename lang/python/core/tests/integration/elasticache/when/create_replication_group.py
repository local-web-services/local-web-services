"""When: a "elasticache" "replication group" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when('a "elasticache" "replication group" is created')
def create_replication_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.CreateReplicationGroup"},
        json={
            "ReplicationGroupId": INT_RG_ID,
            "ReplicationGroupDescription": "int-test-rg",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
