"""When: a database instance modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a database instance modification completes")
def finish_modify_db_instance(client: TestClient, world: dict):
    pytest.skip("ModifyDBInstance is not yet implemented in lws.")
