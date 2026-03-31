"""When: a "documentdb" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_INSTANCE


@when('a "documentdb" "instance" finishes creating')
def finish_creating_instance(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post(
        "DescribeDBInstances", {"DBInstanceIdentifier": INT_INSTANCE}
    )
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
