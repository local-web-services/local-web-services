"""When: a "dynamodb" "table" is created with streaming enabled"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when('a "dynamodb" "table" is created with streaming enabled')
def create_dynamodb_table_with_stream(lws_session, world):
    try:
        resp = lws_session.client("dynamodb").create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
            StreamSpecification={"StreamEnabled": True, "StreamViewType": "NEW_AND_OLD_IMAGES"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
