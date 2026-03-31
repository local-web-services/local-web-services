"""Given: the "api gateway" "API" had no Lambda integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" had no Lambda integration configured')
def apigw_lambda_api_has_no_lambda_integration():
    """No-op: APIs have no Lambda integration configured by default."""
