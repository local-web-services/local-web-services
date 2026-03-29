"""Given: bid in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("bid in bucket_status")
def lambda_s3tables_bid_in_bucket_status(lws_session):
    LambdaS3tablesTestClient(lws_session).create_table_bucket()
