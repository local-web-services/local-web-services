"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given("the bucket already exists")
def s3api_lambda_bucket_already_exists(lws_session):
    S3apiLambdaTestClient(lws_session).create_bucket()
