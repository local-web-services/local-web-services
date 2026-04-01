"""Given: the "lambda" "function" was not "FAILED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "FAILED"')
def function_is_not_failed(world):
    """Signal that lws does not enforce FAILED lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
