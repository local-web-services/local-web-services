"""When: a replica instance is promoted to primary during failover"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a replica instance is promoted to primary during failover")
def promote_replica_to_primary(client: TestClient, world: dict):
    pytest.skip("Replica promotion to primary cannot be triggered in stateless integration tests.")
