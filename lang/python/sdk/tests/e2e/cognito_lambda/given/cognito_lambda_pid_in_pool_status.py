"""Given: pid in pool_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given("pid in pool_status")
def cognito_lambda_pid_in_pool_status(lws_session):
    CognitoLambdaTestClient(lws_session).create_pool()
