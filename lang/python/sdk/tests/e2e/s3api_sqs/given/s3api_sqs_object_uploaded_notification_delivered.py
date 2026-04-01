"""
Given: an object has been uploaded to the bucket and S3 has delivered a notification to the "SQS"
queue
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given(
    'an object has been uploaded to the bucket and S3 has delivered a notification to the "SQS" queue'  # noqa: E501
)
def s3api_sqs_object_uploaded_notification_delivered(lws_session):
    S3apiSqsTestClient(lws_session).create_bucket()
    S3apiSqsTestClient(lws_session)._s3.put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)
