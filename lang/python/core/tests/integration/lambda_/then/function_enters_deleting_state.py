"""Then: the "lambda" "function" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "lambda" "function" will be in "DELETING" state')
def function_enters_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function deletion to succeed but got: {actual_error}"
