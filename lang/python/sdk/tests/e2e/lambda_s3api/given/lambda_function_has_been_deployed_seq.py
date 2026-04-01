"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaS3apiTestClient


@given('a "lambda" "function" is deployed')
def lambda_function_has_been_deployed_seq(lws_session):
    try:
        LambdaS3apiTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
