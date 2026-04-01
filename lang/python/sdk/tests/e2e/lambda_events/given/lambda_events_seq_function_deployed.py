"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given('a "lambda" "function" is deployed')
def lambda_events_seq_function_deployed(lws_session):
    try:
        LambdaEventsTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
