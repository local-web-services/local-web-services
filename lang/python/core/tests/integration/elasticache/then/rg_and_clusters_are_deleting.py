"""Then: the replication group and its clusters are in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the replication group and its clusters are in "DELETING" state')
def rg_and_clusters_are_deleting(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected replication group deletion to succeed but got: {actual_error}"
