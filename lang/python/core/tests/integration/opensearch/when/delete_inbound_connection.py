"""When: an "opensearch" "inbound connection" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an "opensearch" "inbound connection" is deleted')
def delete_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
