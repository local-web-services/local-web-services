"""When: a snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET


@when("a snapshot deletion completes")
def memorydb_snapshot_deletion_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeSnapshots"},
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
