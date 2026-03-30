"""Given: the user is not already "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the user is not already "DELETED"')
def user_is_not_already_deleted():
    """No-op: freshly created users are never DELETED."""
