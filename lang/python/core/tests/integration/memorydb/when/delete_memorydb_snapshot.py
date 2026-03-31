"""When: a "memorydb" "snapshot" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_SNAPSHOT_NAME


@when('a "memorydb" "snapshot" is deleted')
def delete_memorydb_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DeleteSnapshot"},
        json={"SnapshotName": INT_SNAPSHOT_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
