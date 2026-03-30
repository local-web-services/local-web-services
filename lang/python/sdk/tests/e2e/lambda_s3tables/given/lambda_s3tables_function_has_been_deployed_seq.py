"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("a Lambda function has been deployed")
def lambda_s3tables_function_has_been_deployed_seq(lws_session):
    try:
        LambdaS3tablesTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
