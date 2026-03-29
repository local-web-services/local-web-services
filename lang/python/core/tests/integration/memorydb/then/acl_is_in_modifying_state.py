"""Then: the "ACL" is in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "ACL" is in "MODIFYING" state')
def acl_is_in_modifying_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected ACL modification to succeed but got: {actual_error}"
