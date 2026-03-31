"""Given: the "api gateway" "API" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given('the "api gateway" "API" already existed')
def apigw_cognito_api_already_exists(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_api()
