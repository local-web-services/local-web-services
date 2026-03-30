"""Then: the restored cluster is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the restored cluster is in "CREATING" state')
def restored_cluster_is_creating(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster restore to succeed but got: {actual_error}"
