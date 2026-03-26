"""When: a replication group is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_RG_ID


@when("a replication group is deleted")
def delete_replication_group(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DeleteReplicationGroup"},
        json={"ReplicationGroupId": INT_RG_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
