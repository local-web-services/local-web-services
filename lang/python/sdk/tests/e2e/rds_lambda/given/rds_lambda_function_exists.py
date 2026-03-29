"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given("the function exists")
def rds_lambda_function_exists(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
