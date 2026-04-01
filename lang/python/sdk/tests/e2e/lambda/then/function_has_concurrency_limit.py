"""Then: the "lambda" "function" has an unreserved, throttled, or explicit concurrency limit"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" has an unreserved, throttled, or explicit concurrency limit')
def function_has_concurrency_limit(world):
    assert (
        world["error"] is None
    ), f"Expected put_function_concurrency to succeed but got: {world['error']}"
