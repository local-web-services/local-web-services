"""When: a "rds" "instance" is deleted without a final "rds" "snapshot" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('a "rds" "instance" is deleted without a final "rds" "snapshot"')
def delete_db_instance_skip_snapshot(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "DeleteDBInstance", {"DBInstanceIdentifier": INT_DB_INSTANCE, "SkipFinalSnapshot": True}
    )
    _store(world, r)
