"""When: a cluster is restored from a snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a cluster is restored from a snapshot")
def restore_cluster_from_snapshot(client: TestClient, world: dict):
    pytest.skip("RestoreDBClusterFromSnapshot is not yet implemented in lws.")
