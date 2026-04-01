"""When: a "rds" "instance" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('a "rds" "instance" is created')
def create_db_instance(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "CreateDBInstance", {"DBInstanceIdentifier": INT_DB_INSTANCE, "Engine": "postgres"}
    )
    _store(world, r)
