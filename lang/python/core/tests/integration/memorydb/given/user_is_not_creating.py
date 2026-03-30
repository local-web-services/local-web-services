"""Given: the user is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is not "CREATING"')
def user_is_not_creating():
    """No-op: users are not in CREATING state by default in lws."""
