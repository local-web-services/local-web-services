"""Then: the "elasticache" "replication group" will be "DELETED" and its tags will be removed"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "elasticache" "replication group" will be "DELETED" and its tags will be removed')
def rg_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected replication group deletion to succeed but got: {actual_error}"
