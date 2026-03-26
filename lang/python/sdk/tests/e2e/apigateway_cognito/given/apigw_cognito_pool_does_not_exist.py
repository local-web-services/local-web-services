"""Given: the pool does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the pool does not exist")
def apigw_cognito_pool_does_not_exist():
    """No-op: fresh state has no user pools."""
