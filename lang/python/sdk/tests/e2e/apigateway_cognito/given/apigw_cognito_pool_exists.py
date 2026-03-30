"""Given: the pool exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given("the pool exists")
def apigw_cognito_pool_exists(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_pool()
