"""Given: S3 and DynamoDB events are in the buffer"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DDB_TABLE, TEST_S3_BUCKET


@given("S3 and DynamoDB events are in the buffer")
def s3_and_dynamodb_events_are_in_the_buffer(lws_session):
    s3 = lws_session.client("s3")
    try:
        s3.create_bucket(Bucket=TEST_S3_BUCKET)
    except Exception:
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
