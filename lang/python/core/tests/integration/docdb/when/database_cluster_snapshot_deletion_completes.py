"""When: a database cluster snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET


@when("a database cluster snapshot deletion completes")
def database_cluster_snapshot_deletion_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusterSnapshots"},
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
