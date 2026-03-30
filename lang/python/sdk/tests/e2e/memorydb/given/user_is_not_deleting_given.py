"""Given: the user is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is not "DELETING"')
def user_is_not_deleting_given():
    """No-op: users are not in DELETING state by default."""
