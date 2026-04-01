"""Given: a "cognito" "user pool" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given('a "cognito" "user pool" is created')
def apigw_cognito_pool_has_been_created(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_pool()
