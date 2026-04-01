"""When: an outbound cross-cluster connection is created between two "opensearch" "domain"s"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an outbound cross-cluster connection is created between two "opensearch" "domain"s')
def create_outbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
