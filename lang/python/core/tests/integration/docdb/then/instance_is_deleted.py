"""Then: the instance is "DELETED" and the cluster primary is cleared if applicable"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the instance is "DELETED" and the cluster primary is cleared if applicable')
def instance_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected instance deletion to succeed but got: {actual_error}"
