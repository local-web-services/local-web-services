"""Given: the "cognito" "user pool" has no trigger configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" has no trigger configured')
def cognito_lambda_pool_has_no_trigger():
    """No-op: pools have no trigger configured by default."""
