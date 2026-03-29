"""Given: the parent does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the parent does not exist or is not "ACTIVE"')
def parent_does_not_exist_or_not_active(world):
    world["parent_id"] = "nonexistent-parent"
