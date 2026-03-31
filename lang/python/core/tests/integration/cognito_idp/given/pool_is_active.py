"""Given: the "cognito" "user pool" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" was "ACTIVE"')
@given('the "cognito" "user pool" will be "ACTIVE"')
def pool_is_active():
    """No-op: the pool is always ACTIVE immediately after initialisation."""
