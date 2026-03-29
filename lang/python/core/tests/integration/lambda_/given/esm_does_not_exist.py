"""Given: the event source mapping does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event source mapping does not exist")
def esm_does_not_exist(world):
    """Signal that lws does not enforce ESM existence checks in stateless integration tests."""
    world["_skip"] = (
        "lws does not enforce event source mapping existence checks in stateless integration tests."
    )
