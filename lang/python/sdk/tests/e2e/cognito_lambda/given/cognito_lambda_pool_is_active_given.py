"""Given: the pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the pool is "ACTIVE"')
def cognito_lambda_pool_is_active_given():
    """No-op: Cognito user pools are ACTIVE immediately after creation."""
