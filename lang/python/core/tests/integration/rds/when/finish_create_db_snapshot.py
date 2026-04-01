"""When: a "rds" "snapshot" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "rds" "snapshot" finishes creating')
def finish_create_db_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")
