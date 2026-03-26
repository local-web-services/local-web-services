"""When: a cache snapshot is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_SNAPSHOT_ID


@when("a cache snapshot is deleted")
def delete_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DeleteSnapshot"},
        json={"SnapshotName": INT_SNAPSHOT_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
