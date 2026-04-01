"""Given: the "lambda" "function" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "DELETED"')
def function_was_not_deleted(world):
    """Signal that lws does not enforce DELETED lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
