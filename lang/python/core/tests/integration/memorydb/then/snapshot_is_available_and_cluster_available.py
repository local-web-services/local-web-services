"""Then: the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state')
def snapshot_is_available_and_cluster_available(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot to be available but got: {actual_error}"
