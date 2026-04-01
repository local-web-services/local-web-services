"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given('a "lambda" "function" is deployed')
def lambda_function_has_been_deployed_seq(lws_session):
    try:
        LambdaOpensearchTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
