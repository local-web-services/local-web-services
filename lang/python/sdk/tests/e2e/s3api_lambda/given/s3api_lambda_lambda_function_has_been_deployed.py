"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given("a Lambda function has been deployed")
def s3api_lambda_lambda_function_has_been_deployed(lws_session):
    S3apiLambdaTestClient(lws_session).create_function()
