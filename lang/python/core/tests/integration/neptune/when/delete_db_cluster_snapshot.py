"""When: a "documentdb" "cluster" documentdb snapshot is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" neptune snapshot is deleted')
@when('a "documentdb" "cluster" documentdb snapshot is deleted')
def delete_db_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBClusterSnapshot is not yet implemented in lws.")
