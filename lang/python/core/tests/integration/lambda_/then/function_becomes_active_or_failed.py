"""Then: the function becomes "ACTIVE" or "FAILED" non-deterministically"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the function becomes "ACTIVE" or "FAILED" non-deterministically')
def function_becomes_active_or_failed(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected deployment resolution to succeed but got: {actual_error}"
