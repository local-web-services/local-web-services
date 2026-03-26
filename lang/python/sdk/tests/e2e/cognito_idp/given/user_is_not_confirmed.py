"""Given: the user is not "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is not "CONFIRMED"')
def user_is_not_confirmed():
    """No-op: users created via AdminCreateUser are in FORCE_CHANGE_PASSWORD, not CONFIRMED."""
