"""When: a "dynamodb" "table" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _ITEM_KEY, TEST_TABLE


@when('a "dynamodb" "table" is created')
def create_dynamodb_table_apigw(lws_session, world):
    try:
        resp = lws_session.client("dynamodb").create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": _ITEM_KEY, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": _ITEM_KEY, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
