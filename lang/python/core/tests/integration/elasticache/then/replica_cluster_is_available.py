"""Then: the replica "elasticache" "cluster" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the replica "elasticache" "cluster" will be "AVAILABLE"')
def replica_cluster_is_available(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected replica creation to succeed but got: {actual_error}"
