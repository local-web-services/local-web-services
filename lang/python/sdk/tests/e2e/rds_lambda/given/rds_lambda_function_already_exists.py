"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('the "lambda" "function" already existed')
def rds_lambda_function_already_exists(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
