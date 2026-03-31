"""Given: the "cognito" "user" was not "DISABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" was not "DISABLED"')
def user_is_not_disabled():
    """No-op: users created via AdminCreateUser are enabled (not disabled) by default."""
