"""Given: the "api gateway" "API" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" did not exist')
def apigw_lambda_api_does_not_exist():
    """No-op: fresh state has no REST APIs."""
