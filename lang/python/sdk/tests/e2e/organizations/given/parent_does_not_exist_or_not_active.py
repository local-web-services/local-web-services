"""Given: the "organizations" "parent" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "parent" did not exist or was "ACTIVE"')
def parent_does_not_exist_or_not_active(world):
    world["parent_id"] = "nonexistent-parent"
