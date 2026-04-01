"""When: CreateTable is called on the DynamoDB provider"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DDB_TABLE


@when("CreateTable is called on the DynamoDB provider")
def create_table_is_called_on_the_dynamodb_provider(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").create_table(
            TableName=TEST_DDB_TABLE,
            KeySchema=[{"AttributeName": "pk", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "pk", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
