"""When: a "rds" "instance" is restored from a "rds" "snapshot" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "rds" "instance" is restored from a "rds" "snapshot"')
def restore_db_instance_from_snapshot(client: TestClient, world: dict):
    pytest.skip("RestoreDBInstanceFromDBSnapshot is not yet implemented in lws.")
