"""When: a DynamoDB table is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsDynamodbTestClient
from ..constants import TEST_PK, TEST_TABLE


@when("a DynamoDB table is created")
def create_dynamo_table(lws_session, world):
    try:
        world["result"] = EventsDynamodbTestClient(lws_session)._dynamo.create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
