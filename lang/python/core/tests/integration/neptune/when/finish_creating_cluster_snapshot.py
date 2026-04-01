"""When: a "documentdb" "cluster" documentdb snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "documentdb" "cluster" documentdb snapshot finishes creating')
def finish_creating_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("CreateDBClusterSnapshot is not yet implemented in lws.")
