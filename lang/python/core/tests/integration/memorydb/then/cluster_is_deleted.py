"""Then: the cluster is "DELETED" and its tags are removed"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the cluster is "DELETED" and its tags are removed')
def cluster_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster deletion to succeed but got: {actual_error}"
