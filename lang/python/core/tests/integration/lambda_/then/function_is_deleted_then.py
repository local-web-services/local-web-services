"""Then: the "lambda" "function" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "lambda" "function" will be "DELETED"')
def function_is_deleted_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function deletion to succeed but got: {actual_error}"
