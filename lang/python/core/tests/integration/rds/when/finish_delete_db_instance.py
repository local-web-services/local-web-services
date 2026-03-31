"""When: a "documentdb" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('a "documentdb" "instance" deletion completes')
def finish_delete_db_instance(client: TestClient, world: dict):
    check = RdsTestClient(client).post(
        "DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE}
    )
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = RdsTestClient(client).post(
        "DeleteDBInstance", {"DBInstanceIdentifier": INT_DB_INSTANCE, "SkipFinalSnapshot": True}
    )
    _store(world, r)
