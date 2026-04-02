"""Given: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given(
    'an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"'
)
def s3api_events_object_uploaded_event_delivered(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
    S3apiEventsTestClient(lws_session)._s3.put_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
    )
