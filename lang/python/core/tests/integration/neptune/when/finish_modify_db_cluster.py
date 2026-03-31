"""When: a "documentdb" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "documentdb" "cluster" modification completes')
def finish_modify_db_cluster(client: TestClient, world: dict):
    pytest.skip("ModifyDBCluster is not yet implemented in lws.")
