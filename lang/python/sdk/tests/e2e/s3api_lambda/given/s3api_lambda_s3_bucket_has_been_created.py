"""Given: a "s3" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given('a "s3" "bucket" is created')
def s3api_lambda_s3_bucket_has_been_created(lws_session):
    S3apiLambdaTestClient(lws_session).create_bucket()
