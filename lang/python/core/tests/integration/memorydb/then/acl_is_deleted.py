"""Then: the "memorydb" "ACL" will be deleted"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "memorydb" "ACL" will be deleted')
def acl_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected ACL deletion to succeed but got: {actual_error}"
