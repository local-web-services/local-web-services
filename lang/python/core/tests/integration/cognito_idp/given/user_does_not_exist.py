"""Given: the user does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the user does not exist")
def user_does_not_exist(world):
    world["username"] = "nonexistent-user@example.com"
