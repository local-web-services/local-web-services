"""Given: a "s3" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('a "s3" "bucket" is created')
def s3api_sqs_s3_bucket_has_been_created(lws_session):
    S3apiSqsTestClient(lws_session).create_bucket()
