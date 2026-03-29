"""When: a database instance is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_INSTANCE, _store


@when("a database instance is deleted")
def delete_db_instance(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post("DeleteDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)
