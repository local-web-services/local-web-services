"""Then: the tag will be cleared from the "lambda" "function" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the tag will be cleared from the "lambda" "function"')
def tag_cleared_from_function(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tag to be removed but got: {actual_error}"
