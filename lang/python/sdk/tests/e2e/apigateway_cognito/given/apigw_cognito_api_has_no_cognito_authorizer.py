"""Given: the "api gateway" "api" has no Cognito authorizer configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" has no Cognito authorizer configured')
def apigw_cognito_api_has_no_cognito_authorizer():
    """No-op: APIs have no Cognito authorizer configured by default."""
