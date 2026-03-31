"""Given: the "lambda" "function" was not "PENDING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "PENDING"')
def function_is_not_pending(world):
    """Signal that lws does not enforce PENDING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
