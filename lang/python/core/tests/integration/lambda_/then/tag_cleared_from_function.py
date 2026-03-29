"""Then: the tag is cleared from the function"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then("the tag is cleared from the function")
def tag_cleared_from_function(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tag to be removed but got: {actual_error}"
