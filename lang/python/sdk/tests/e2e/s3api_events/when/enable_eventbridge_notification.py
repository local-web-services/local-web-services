"""When: "eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUCKET


@when(
    '"eventbridge" notifications are enabled on the "s3" "bucket" targeting a specific "eventbridge" "bus"'
)
def enable_eventbridge_notification(lws_session, world):
    try:
        world["result"] = S3apiEventsTestClient(
            lws_session
        )._s3.put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={"EventBridgeConfiguration": {}},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
