"""When: a "documentdb" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE


@when('a "documentdb" "instance" finishes creating')
def finish_creating_db_instance(client: TestClient, world: dict):
    r = RdsTestClient(client).post("DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE})
    if r.status_code != 200:
        world["result"] = None
        world["error"] = r.json()
        return
    instances = r.json().get("DBInstances", [])
    if not instances:
        world["result"] = None
        world["error"] = {"message": "DB instance not found"}
        return
    world["result"] = r.json()
    world["error"] = None
