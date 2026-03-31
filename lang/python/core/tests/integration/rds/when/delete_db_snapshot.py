"""When: a "rds" "snapshot" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "rds" "snapshot" is deleted')
def delete_db_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBSnapshot is not yet implemented in lws.")
