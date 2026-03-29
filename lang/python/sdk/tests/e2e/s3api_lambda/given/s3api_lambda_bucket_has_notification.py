"""Given: the bucket has a notification configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given("the bucket has a notification configured")
def s3api_lambda_bucket_has_notification(lws_session):
    try:
        S3apiLambdaTestClient(lws_session).create_bucket()
    except Exception:
        pass
    S3apiLambdaTestClient(lws_session).create_function()
    S3apiLambdaTestClient(lws_session).configure_notification()
