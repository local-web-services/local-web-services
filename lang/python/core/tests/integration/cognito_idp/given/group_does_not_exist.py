"""Given: the group does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the group does not exist")
def group_does_not_exist(world):
    world["group_name"] = "nonexistent-group"
