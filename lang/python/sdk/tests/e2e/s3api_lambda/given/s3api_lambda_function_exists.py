"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given("the function exists")
def s3api_lambda_function_exists(lws_session):
    S3apiLambdaTestClient(lws_session).create_function()
