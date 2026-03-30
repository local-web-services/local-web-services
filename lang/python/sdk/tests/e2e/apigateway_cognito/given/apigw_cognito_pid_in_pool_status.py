"""Given: pid in pool_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayCognitoTestClient


@given("pid in pool_status")
def apigw_cognito_pid_in_pool_status(lws_session):
    ApigatewayCognitoTestClient(lws_session).create_pool()
