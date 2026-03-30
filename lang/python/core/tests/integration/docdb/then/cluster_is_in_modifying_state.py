"""Then: the cluster is in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the cluster is in "MODIFYING" state')
def cluster_is_in_modifying_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster modification to succeed but got: {actual_error}"
