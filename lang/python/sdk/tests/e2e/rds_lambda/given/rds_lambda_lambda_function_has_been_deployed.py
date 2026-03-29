"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given("a Lambda function has been deployed")
def rds_lambda_lambda_function_has_been_deployed(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
