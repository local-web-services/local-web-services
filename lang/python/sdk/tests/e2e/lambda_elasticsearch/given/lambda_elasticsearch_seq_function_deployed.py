"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaElasticsearchTestClient


@given("a Lambda function has been deployed")
def lambda_elasticsearch_seq_function_deployed(lws_session):
    try:
        LambdaElasticsearchTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
