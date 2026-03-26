"""
Given: an object has been uploaded but event delivery has failed because the bus has been deleted
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given("an object has been uploaded but event delivery has failed because the bus has been deleted")
def s3api_events_object_uploaded_event_failed(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
    S3apiEventsTestClient(lws_session)._s3.put_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
    )
