"""When: a "neptune" "cluster" is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" is stopped')
def stop_db_cluster(client: TestClient, world: dict):
    pytest.skip("StopDBCluster is not yet implemented in lws.")
