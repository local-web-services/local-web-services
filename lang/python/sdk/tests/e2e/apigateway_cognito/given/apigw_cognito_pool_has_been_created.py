"""Given: a Cognito User Pool has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given("a Cognito User Pool has been created")
def apigw_cognito_pool_has_been_created(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_pool()
