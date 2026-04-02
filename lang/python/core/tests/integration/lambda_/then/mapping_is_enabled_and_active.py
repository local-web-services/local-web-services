"""Then: the "lambda" "event source mapping" will be "ENABLED" and active"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "lambda" "event source mapping" will be "ENABLED" and active')
def mapping_is_enabled_and_active(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping enable to succeed but got: {actual_error}"
