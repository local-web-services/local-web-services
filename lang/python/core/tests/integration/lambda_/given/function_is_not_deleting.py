"""Given: the "lambda" "function" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "DELETING"')
def function_is_not_deleting(world):
    """Signal that lws does not enforce DELETING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
