"""When: an inbound cross-cluster connection is rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an inbound cross-cluster connection is rejected")
def reject_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
