"""Then: a new cluster is in "CREATING" state and associated with the replication group"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('a new cluster is in "CREATING" state and associated with the replication group')
def new_cluster_is_creating_in_rg(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected replica addition to succeed but got: {actual_error}"
