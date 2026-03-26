"""When: multi-"AZ" is enabled on a database instance"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('multi-"AZ" is enabled on a database instance')
def enable_multi_az(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "ModifyDBInstance", {"DBInstanceIdentifier": INT_DB_INSTANCE, "MultiAZ": True}
    )
    _store(world, r)
