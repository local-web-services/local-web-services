"""When: an automated backup runs on an available "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an automated backup runs on an available "rds" "instance"')
def automated_backup(client: TestClient, world: dict):
    pytest.skip("CreateDBSnapshot is not yet implemented in lws.")
