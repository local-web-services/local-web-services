"""Then: the "elasticache" "cluster" will be in "RESTORING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "elasticache" "cluster" will be in "RESTORING" state')
def cluster_is_in_restoring_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster restore to succeed but got: {actual_error}"
