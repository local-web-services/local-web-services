"""When: a database instance reboot completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_INSTANCE, _store


@when("a database instance reboot completes")
def finish_reboot_db_instance(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post("RebootDBInstance", {"DBInstanceIdentifier": INT_INSTANCE})
    _store(world, r)
