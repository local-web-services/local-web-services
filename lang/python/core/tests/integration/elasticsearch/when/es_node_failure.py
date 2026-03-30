"""When: a node failure occurs in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a node failure occurs in an active domain")
def es_node_failure(client: TestClient, world: dict):
    pytest.skip("Node failure simulation cannot be triggered in stateless integration tests.")
