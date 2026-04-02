"""Given: the "s3" "bucket" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given('the "lambda" "function" already existed')
def s3api_lambda_function_already_exists(lws_session):
    S3apiLambdaTestClient(lws_session).create_function()
