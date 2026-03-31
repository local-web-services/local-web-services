"""Given: the "cognito" "user" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" was "DELETED"')
def user_is_not_deleted():
    """No-op: freshly created users are not DELETED."""
