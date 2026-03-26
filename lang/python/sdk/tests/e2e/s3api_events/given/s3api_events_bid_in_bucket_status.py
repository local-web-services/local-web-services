"""Given: bid in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given("bid in bucket_status")
def s3api_events_bid_in_bucket_status(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
