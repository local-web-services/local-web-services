"""Given: the pool does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the pool does not already exist")
def cognito_lambda_pool_not_already_exist():
    """No-op: fresh state has no user pools."""
