"""Then: the "lambda" "function" returns to "PENDING" state for redeployment"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" returns to "PENDING" state for redeployment')
def function_returns_to_pending(world):
    assert (
        world["error"] is None
    ), f"Expected update_function_code to succeed but got: {world['error']}"
