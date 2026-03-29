"""Given: the "API" exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given('the "API" exists')
def apigw_cognito_api_exists(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_api()
