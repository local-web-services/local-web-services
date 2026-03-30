"""When: an inbound connection finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an inbound connection finishes deleting")
def finish_deleting_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
