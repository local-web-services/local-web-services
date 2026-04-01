"""Given: the "cognito" "user" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" did not exist')
def user_does_not_exist(world):
    world["username"] = "nonexistent-user@example.com"
