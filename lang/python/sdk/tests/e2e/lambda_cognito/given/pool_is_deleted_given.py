"""Given: the "cognito" "user pool" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" was "DELETED"')
def pool_is_deleted_given():
    """No-op: fresh state has no pools (simulates deleted pool)."""
