"""Given: events for CreateQueue and CreateTable are in the buffer"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DDB_TABLE, TEST_SQS_QUEUE


@given("events for CreateQueue and CreateTable are in the buffer")
def events_for_create_queue_and_create_table_are_in_the_buffer(lws_session):
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
