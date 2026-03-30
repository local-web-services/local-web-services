"""When: a database cluster snapshot is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a database cluster snapshot is deleted")
def delete_db_cluster_snapshot(client: TestClient, world: dict):
    pytest.skip("DeleteDBClusterSnapshot is not yet implemented in lws.")
