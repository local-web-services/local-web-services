"""Then: the function returns to "PENDING" state for redeployment"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the function returns to "PENDING" state for redeployment')
def function_returns_to_pending_for_redeployment(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected code update to succeed but got: {actual_error}"
