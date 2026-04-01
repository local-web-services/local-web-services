"""When: a "documentdb" "cluster" configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" configuration is modified')
@when('a "documentdb" "cluster" configuration is modified')
def modify_db_cluster(client: TestClient, world: dict):
    pytest.skip("ModifyDBCluster is not yet implemented in lws.")
