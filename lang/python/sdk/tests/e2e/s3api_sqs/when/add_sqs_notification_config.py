"""When: an "SQS" notification configuration is added to the bucket"""

from __future__ import annotations

from pytest_bdd import when

from ..client import S3apiSqsTestClient
from ..constants import TEST_BUCKET, TEST_QUEUE


@when('an "SQS" notification configuration is added to the bucket')
def add_sqs_notification_config(lws_session, world):
    queue_arn = f"arn:aws:sqs:us-east-1:000000000000:{TEST_QUEUE}"
    try:
        world["result"] = S3apiSqsTestClient(lws_session)._s3.put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={
                "QueueConfigurations": [
                    {
                        "Id": "e2e-test-sqs-config-1",
                        "QueueArn": queue_arn,
                        "Events": ["s3:ObjectCreated:*"],
                    }
                ]
            },
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
