"""Given: the "lambda" "function" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('the "lambda" "function" existed and was "ACTIVE"')
def rds_lambda_function_exists_and_active(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
