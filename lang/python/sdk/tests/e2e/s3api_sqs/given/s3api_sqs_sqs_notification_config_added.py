"""Given: an "SQS" notification configuration has been added to the bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient
from ..constants import TEST_BUCKET, TEST_QUEUE


@given('an "SQS" notification configuration has been added to the bucket')
def s3api_sqs_sqs_notification_config_added(lws_session):
    S3apiSqsTestClient(lws_session).create_bucket()
    S3apiSqsTestClient(lws_session).create_queue()
    queue_arn = f"arn:aws:sqs:us-east-1:000000000000:{TEST_QUEUE}"
    S3apiSqsTestClient(lws_session)._s3.put_bucket_notification_configuration(
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
