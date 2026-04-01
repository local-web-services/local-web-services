"""Given: an object is uploaded and S3 delivers an event to the EventBridge bus"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given("an object is uploaded and S3 delivers an event to the EventBridge bus")
def s3api_events_object_uploaded_event_delivered(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
    S3apiEventsTestClient(lws_session)._s3.put_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
    )
