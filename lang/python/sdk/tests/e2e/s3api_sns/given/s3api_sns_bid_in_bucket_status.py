"""Given: bid in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given("bid in bucket_status")
def s3api_sns_bid_in_bucket_status(lws_session):
    S3apiSnsTestClient(lws_session).create_bucket()
