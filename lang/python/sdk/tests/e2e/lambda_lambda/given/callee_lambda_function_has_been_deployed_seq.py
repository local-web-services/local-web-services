"""Given: a callee "lambda" "function" is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given('a callee "lambda" "function" is deployed')
def callee_lambda_function_has_been_deployed_seq(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
