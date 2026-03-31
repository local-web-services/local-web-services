"""When: a "documentdb" "instance" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_INSTANCE_ID


@when('a "documentdb" "instance" is deleted')
def delete_database_instance(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DeleteDBInstance"},
        json={"DBInstanceIdentifier": INT_INSTANCE_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
