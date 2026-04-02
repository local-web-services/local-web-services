"""Then: the "lambda" "event source mapping" will be "ENABLED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "lambda" "event source mapping" will be "ENABLED"')
def mapping_is_enabled_then(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping to be enabled but got: {actual_error}"
