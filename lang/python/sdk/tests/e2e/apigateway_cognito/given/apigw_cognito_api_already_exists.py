"""Given: the "API" already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given('the "API" already exists')
def apigw_cognito_api_already_exists(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_api()
