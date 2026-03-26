"""When: a replication group configuration is modified"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when("a replication group configuration is modified")
def modify_replication_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.ModifyReplicationGroup"},
        json={
            "ReplicationGroupId": INT_RG_ID,
            "ApplyImmediately": True,
            "ReplicationGroupDescription": "int-test-rg-modified",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
