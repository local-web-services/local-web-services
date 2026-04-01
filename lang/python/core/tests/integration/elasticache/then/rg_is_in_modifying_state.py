"""Then: the "elasticache" "replication group" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "elasticache" "replication group" will be in "MODIFYING" state')
def rg_is_in_modifying_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected replication group modification to succeed but got: {actual_error}"
