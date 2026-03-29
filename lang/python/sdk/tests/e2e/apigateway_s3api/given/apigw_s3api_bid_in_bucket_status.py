"""Given: bid in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given("bid in bucket_status")
def apigw_s3api_bid_in_bucket_status(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
