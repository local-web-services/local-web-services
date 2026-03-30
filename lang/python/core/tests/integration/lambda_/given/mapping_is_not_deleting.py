"""Given: the mapping is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the mapping is not "DELETING"')
def mapping_is_not_deleting(world):
    """Signal that lws does not enforce DELETING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
