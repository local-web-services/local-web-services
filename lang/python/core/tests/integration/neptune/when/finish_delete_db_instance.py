"""When: a "documentdb" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_INSTANCE, _store


@when('a "documentdb" "instance" deletion completes')
def finish_delete_db_instance(client: TestClient, world: dict):
    check = NeptuneTestClient(client).post(
        "DescribeDBInstances", {"DBInstanceIdentifier": INT_INSTANCE}
    )
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = NeptuneTestClient(client).post("DeleteDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)
