"""Then: the "cognito" "user" was "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "cognito" "user" was "DELETED"')
def user_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected user deletion to succeed but got: {actual_error}"
