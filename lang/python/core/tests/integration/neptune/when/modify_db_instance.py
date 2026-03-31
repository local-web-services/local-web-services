"""When: a "documentdb" "instance" configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "instance" configuration is modified')
@when('a "documentdb" "instance" configuration is modified')
def modify_db_instance(client: TestClient, world: dict):
    pytest.skip("ModifyDBInstance is not yet implemented in lws.")
