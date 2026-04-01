"""When: PutItem is called on the DynamoDB provider"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DDB_TABLE


@when("PutItem is called on the DynamoDB provider")
def put_item_is_called_on_the_dynamodb_provider(lws_session, world):
    ddb = lws_session.client("dynamodb")
    try:
        ddb.create_table(
            TableName=TEST_DDB_TABLE,
            KeySchema=[{"AttributeName": "pk", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "pk", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
    except Exception:
        pass
    try:
        world["result"] = ddb.put_item(
            TableName=TEST_DDB_TABLE,
            Item={"pk": {"S": "e2e-item-key"}},
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
