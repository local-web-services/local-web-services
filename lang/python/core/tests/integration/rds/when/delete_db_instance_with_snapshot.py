"""When: a "rds" "instance" is deleted with a final "rds" "snapshot" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, INT_DB_SNAPSHOT, _store


@when('a "rds" "instance" is deleted with a final "rds" "snapshot"')
def delete_db_instance_with_snapshot(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "DeleteDBInstance",
        {
            "DBInstanceIdentifier": INT_DB_INSTANCE,
            "SkipFinalSnapshot": False,
            "FinalDBSnapshotIdentifier": INT_DB_SNAPSHOT,
        },
    )
    _store(world, r)
