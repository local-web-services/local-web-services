"""Given: the "cognito" "user pool" did not exist or was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" did not exist or was "DELETED"')
def pool_not_exist_or_deleted():
    """No-op: fresh state has no user pools."""
