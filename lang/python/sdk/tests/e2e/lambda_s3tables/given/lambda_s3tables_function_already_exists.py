"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given('the "lambda" "function" already existed')
def lambda_s3tables_function_already_exists(lws_session):
    LambdaS3tablesTestClient(lws_session).create_function()
