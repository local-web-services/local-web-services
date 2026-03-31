"""Then: the "lambda" "function"'s resource policy will be cleared"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "lambda" "function"\'s resource policy will be cleared')
def function_resource_policy_cleared(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected permission to be removed but got: {actual_error}"
