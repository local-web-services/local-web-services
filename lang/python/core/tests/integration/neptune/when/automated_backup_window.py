"""When: an automated backup window runs on an available cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an automated backup window runs on an available cluster")
def automated_backup_window(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")
