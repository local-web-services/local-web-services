"""When: a database instance modification completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when("a database instance modification completes")
def finish_modify_db_instance(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "ModifyDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "DBInstanceClass": "db.t3.small"},
    )
    _store(world, r)
