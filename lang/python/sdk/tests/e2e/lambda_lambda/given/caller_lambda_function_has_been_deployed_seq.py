"""Given: a caller Lambda function has been deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given("a caller Lambda function has been deployed")
def caller_lambda_function_has_been_deployed_seq(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
