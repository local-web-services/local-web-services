"""Then: the cluster is in "FAILED" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the cluster is in "FAILED" state')
def cluster_is_in_failed_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is not None, "Expected cluster creation to fail but it succeeded"
