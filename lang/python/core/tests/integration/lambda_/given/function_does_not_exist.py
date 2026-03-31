"""Given: the "lambda" "function" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not exist')
def function_does_not_exist(world):
    """Signal that lws does not enforce function existence for all operations."""
    world["_skip"] = (
        "lws does not enforce function existence checks in stateless integration tests."
    )
