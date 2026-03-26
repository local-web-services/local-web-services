"""When: a failover is triggered and a replica is promoted to primary"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@when("a failover is triggered and a replica is promoted to primary")
def trigger_failover(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.FailoverDBCluster"},
        json={"DBClusterIdentifier": INT_CLUSTER_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
