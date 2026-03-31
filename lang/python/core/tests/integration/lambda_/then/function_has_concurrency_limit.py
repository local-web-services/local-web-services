"""Then: the "lambda" "function" has an unreserved, throttled, or explicit concurrency limit"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" has an unreserved, throttled, or explicit concurrency limit')
def function_has_concurrency_limit(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected concurrency setting to succeed but got: {actual_error}"
