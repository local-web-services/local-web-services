"""Then: the "elasticache" "replication group" and its primary "elasticache" "cluster" are "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then(
    'the "elasticache" "replication group" and its primary "elasticache" "cluster" are "AVAILABLE"'
)
def rg_and_primary_are_available(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected operation to succeed but got: {actual_error}"
