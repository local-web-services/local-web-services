"""When: a "documentdb" "cluster" creation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "documentdb" "cluster" creation fails')
def fail_cluster_creation(client: TestClient, world: dict):
    pytest.skip("Cluster creation failure cannot be triggered in stateless integration tests.")
