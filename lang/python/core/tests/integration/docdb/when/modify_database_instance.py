"""When: a database instance configuration is modified"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_INSTANCE_ID


@when("a database instance configuration is modified")
def modify_database_instance(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.ModifyDBInstance"},
        json={
            "DBInstanceIdentifier": INT_INSTANCE_ID,
            "ApplyImmediately": True,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
