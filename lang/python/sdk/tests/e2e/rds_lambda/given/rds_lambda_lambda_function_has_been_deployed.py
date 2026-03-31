"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('a "lambda" "function" is deployed')
def rds_lambda_lambda_function_has_been_deployed(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
