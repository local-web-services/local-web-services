"""Then: the replication group has a new primary cluster"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then("the replication group has a new primary cluster")
def rg_has_new_primary(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected failover to succeed but got: {actual_error}"
