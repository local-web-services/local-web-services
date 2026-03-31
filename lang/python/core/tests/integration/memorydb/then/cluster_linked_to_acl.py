"""Then: the "memorydb" "cluster" will be linked to the active "ACL" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "memorydb" "cluster" will be linked to the active "ACL"')
def cluster_linked_to_acl(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected ACL association to succeed but got: {actual_error}"
