"""Given: the mapping is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the mapping is not "CREATING"')
def mapping_is_not_creating(world):
    """Signal that lws does not enforce CREATING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )
