"""Given: the "dynamodb" "table" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" was not "ACTIVE"')
def dynamodb_lambda_table_is_not_active_given(lws_session, world):
    try:
        DynamodbLambdaTestClient(lws_session)._dynamodb.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    DynamodbLambdaTestClient(lws_session).create_table()
    world["result"] = None
    world["error"] = None
