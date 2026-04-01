"""Given: several service API calls have been made"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DDB_TABLE, TEST_SQS_QUEUE


@given("several service API calls have been made")
def several_service_api_calls_have_been_made(lws_session):
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
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
