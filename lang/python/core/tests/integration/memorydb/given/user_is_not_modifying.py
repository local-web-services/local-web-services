"""Given: the user is not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is not "MODIFYING"')
def user_is_not_modifying():
    """No-op: users are not in MODIFYING state by default."""
