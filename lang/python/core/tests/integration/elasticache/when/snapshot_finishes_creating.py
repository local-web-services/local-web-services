"""When: an "elasticache" "snapshot" finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_SNAPSHOT_ID


@when('an "elasticache" "snapshot" finishes creating')
def snapshot_finishes_creating(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeSnapshots"},
        json={"SnapshotName": INT_SNAPSHOT_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
