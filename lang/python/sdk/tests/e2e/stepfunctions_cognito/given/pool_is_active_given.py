"""Given: the "cognito" "user pool" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" was "ACTIVE"')
def pool_is_active_given():
    """No-op: Cognito user pools are active immediately after creation."""
