"""Given: the user is "FORCE_CHANGE_PASSWORD" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is "FORCE_CHANGE_PASSWORD"')
def user_is_force_change_password():
    """No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD by default."""
