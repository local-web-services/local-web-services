"""When: a database snapshot is created from an instance"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a database snapshot is created from an instance")
def create_db_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")
