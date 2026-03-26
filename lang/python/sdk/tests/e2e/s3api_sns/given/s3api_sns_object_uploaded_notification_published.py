"""Given: an object has been uploaded and S3 has published a notification to the "SNS" topic"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('an object has been uploaded and S3 has published a notification to the "SNS" topic')
def s3api_sns_object_uploaded_notification_published(lws_session):
    S3apiSnsTestClient(lws_session).create_bucket()
    S3apiSnsTestClient(lws_session)._s3.put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)
