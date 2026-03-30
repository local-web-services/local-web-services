"""Given: the user is "UNCONFIRMED" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is "UNCONFIRMED"')
def user_is_unconfirmed():
    """No-op: AdminCreateUser with auto_confirm=False leaves users UNCONFIRMED."""
