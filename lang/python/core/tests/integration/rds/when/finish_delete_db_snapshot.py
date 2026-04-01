"""When: a "rds" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "rds" "snapshot" deletion completes')
def finish_delete_db_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBSnapshot is not yet implemented in lws.")
