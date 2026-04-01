"""When: a "rds" "snapshot" is created from a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "rds" "snapshot" is created from a "rds" "instance"')
def create_db_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")
