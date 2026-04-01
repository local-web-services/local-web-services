"""Given: the "cognito" "group" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "group" did not exist')
def group_does_not_exist(world):
    world["group_name"] = "nonexistent-group"
