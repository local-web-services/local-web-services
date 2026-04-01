"""Given: the "api gateway" "API" had no integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" had no integration configured')
def apigw_lambda_api_has_no_integration():
    """No-op: APIs have no integration configured by default."""
