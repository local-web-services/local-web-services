"""Then: the cluster remains "AVAILABLE" after the shard failover"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the cluster remains "AVAILABLE" after the shard failover')
def cluster_remains_available_after_failover(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected failover to succeed but got: {actual_error}"
