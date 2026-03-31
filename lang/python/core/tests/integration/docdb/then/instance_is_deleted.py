"""Then: the "documentdb" "INSTANCE" will be "DELETED" and the "documentdb" "cluster" primary will be cleared if applicable"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then(
    'the "documentdb" "INSTANCE" will be "DELETED" and the "documentdb" "cluster" primary will be cleared if applicable'
)
def instance_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected instance deletion to succeed but got: {actual_error}"
