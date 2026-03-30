"""Given: the destination parent is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the destination parent is not "ACTIVE"')
def destination_parent_not_active(world):
    world["dest_parent_id"] = "nonexistent-dest"
