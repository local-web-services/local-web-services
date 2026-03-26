"""Then: the user is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the user is in "DELETING" state')
def user_is_in_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected user deletion to succeed but got: {actual_error}"
