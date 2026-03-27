"""Given: the bucket has an EventBridge notification configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUCKET


@given("the bucket has an EventBridge notification configured")
def bucket_has_eventbridge_notification(lws_session):
    client = S3apiEventsTestClient(lws_session)
    client.create_bucket()
    client._s3.put_bucket_notification_configuration(
        Bucket=TEST_BUCKET,
        NotificationConfiguration={"EventBridgeConfiguration": {}},
    )
