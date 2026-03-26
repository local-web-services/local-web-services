"""When: an "SNS" notification configuration is added to the bucket"""

from __future__ import annotations

from pytest_bdd import when

from ..client import S3apiSnsTestClient
from ..constants import TEST_BUCKET, _topic_arn


@when('an "SNS" notification configuration is added to the bucket')
def add_sns_notification_config(lws_session, world):
    try:
        world["result"] = S3apiSnsTestClient(lws_session)._s3.put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={
                "TopicConfigurations": [
                    {
                        "Id": "e2e-test-sns-config-1",
                        "TopicArn": _topic_arn(),
                        "Events": ["s3:ObjectCreated:*"],
                    }
                ]
            },
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
