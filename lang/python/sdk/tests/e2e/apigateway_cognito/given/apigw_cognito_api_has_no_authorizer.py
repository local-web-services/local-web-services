"""Given: the "API" has no authorizer configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "API" has no authorizer configured')
def apigw_cognito_api_has_no_authorizer():
    """No-op: APIs have no authorizer configured by default."""
