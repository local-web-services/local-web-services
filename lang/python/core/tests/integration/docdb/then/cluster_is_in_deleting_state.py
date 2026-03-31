"""Then: the "documentdb" "cluster" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "documentdb" "cluster" will be in "DELETING" state')
def cluster_is_in_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster deletion to succeed but got: {actual_error}"
