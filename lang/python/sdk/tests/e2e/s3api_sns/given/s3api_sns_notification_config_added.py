"""Given: a "sns" notification configuration is added to the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient
from ..constants import TEST_BUCKET, _topic_arn


@given('a "sns" notification configuration is added to the "s3" "bucket"')
def s3api_sns_notification_config_added(lws_session):
    S3apiSnsTestClient(lws_session).create_bucket()
    S3apiSnsTestClient(lws_session).create_topic()
    S3apiSnsTestClient(lws_session)._s3.put_bucket_notification_configuration(
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
