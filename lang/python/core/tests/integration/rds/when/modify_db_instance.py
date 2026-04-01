"""When: a "documentdb" "instance" configuration is modified"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('a "rds" "instance" configuration is modified')
@when('a "documentdb" "instance" configuration is modified')
def modify_db_instance(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "ModifyDBInstance",
        {"DBInstanceIdentifier": INT_DB_INSTANCE, "DBInstanceClass": "db.t3.small"},
    )
    _store(world, r)
