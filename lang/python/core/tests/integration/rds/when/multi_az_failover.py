"""When: a multi-"AZ" failover is triggered on a "rds" "instance" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, _store


@when('a multi-"AZ" failover is triggered on a "rds" "instance"')
def multi_az_failover(client: TestClient, world: dict):
    r = RdsTestClient(client).post(
        "RebootDBInstance", {"DBInstanceIdentifier": INT_DB_INSTANCE, "ForceFailover": True}
    )
    _store(world, r)
