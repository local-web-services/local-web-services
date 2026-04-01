"""Given: the bus did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" did not exist or was "ACTIVE"')
def pool_not_exist_or_not_active():
    """No-op: fresh state has no pools."""
