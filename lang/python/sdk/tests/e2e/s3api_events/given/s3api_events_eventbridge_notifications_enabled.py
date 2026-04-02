"""Given: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUCKET


@given(
    '"eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"'
)
def s3api_events_eventbridge_notifications_enabled(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
    S3apiEventsTestClient(lws_session).create_bus()
    S3apiEventsTestClient(lws_session)._s3.put_bucket_notification_configuration(
        Bucket=TEST_BUCKET, NotificationConfiguration={"EventBridgeConfiguration": {}}
    )
