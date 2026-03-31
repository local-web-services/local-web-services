"""Given: a "s3" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('a "s3" "bucket" is created')
def s3api_events_s3_bucket_has_been_created(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
