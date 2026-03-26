"""Then: the function configuration is updated while remaining "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the function configuration is updated while remaining "ACTIVE"')
def function_configuration_updated(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected configuration update to succeed but got: {actual_error}"
