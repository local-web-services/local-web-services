"""
Given: an object has been put into the bucket and asynchronously invoked the configured Lambda
function
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given(
    "an object has been put into the bucket and asynchronously invoked the configured Lambda function"  # noqa: E501
)
def s3api_lambda_object_put_invoked_lambda(lws_session):
    S3apiLambdaTestClient(lws_session).create_bucket()
    S3apiLambdaTestClient(lws_session)._s3.put_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
    )
