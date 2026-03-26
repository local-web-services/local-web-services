"""When: a database instance modification completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_INSTANCE_ID


@when("a database instance modification completes")
def database_instance_modification_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBInstances"},
        json={"DBInstanceIdentifier": INT_INSTANCE_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
