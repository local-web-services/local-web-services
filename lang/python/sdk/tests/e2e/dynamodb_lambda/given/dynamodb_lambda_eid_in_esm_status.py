"""Given: eid in esm_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("eid in esm_status")
def dynamodb_lambda_eid_in_esm_status(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
