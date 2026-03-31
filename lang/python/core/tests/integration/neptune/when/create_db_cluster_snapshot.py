"""When: a "documentdb" "cluster" documentdb snapshot is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" neptune snapshot is created')
@when('a "documentdb" "cluster" documentdb snapshot is created')
def create_db_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")
