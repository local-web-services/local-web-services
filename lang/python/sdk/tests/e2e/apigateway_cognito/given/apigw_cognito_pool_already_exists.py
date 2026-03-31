"""Given: the "cognito" "user pool" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given('the "cognito" "user pool" already existed')
def apigw_cognito_pool_already_exists(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_pool()
