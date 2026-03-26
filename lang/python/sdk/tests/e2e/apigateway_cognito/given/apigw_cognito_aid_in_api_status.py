"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given("aid in api_status")
def apigw_cognito_aid_in_api_status(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_api()
