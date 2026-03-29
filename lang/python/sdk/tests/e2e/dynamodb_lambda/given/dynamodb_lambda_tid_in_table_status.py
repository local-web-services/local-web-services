"""Given: tid in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("tid in table_status")
def dynamodb_lambda_tid_in_table_status(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
