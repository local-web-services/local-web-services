"""When: a stopped neptune database neptune cluster is started"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a stopped neptune database neptune cluster is started")
def start_db_cluster(client: TestClient, world: dict):
    pytest.skip("StartDBCluster is not yet implemented in lws.")
