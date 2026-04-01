"""Given: the bucket already has a notification configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given("the bucket already has a notification configured")
def s3api_lambda_bucket_already_has_notification(lws_session, world):
    try:
        S3apiLambdaTestClient(lws_session).create_bucket()
    except Exception:
        pass
    S3apiLambdaTestClient(lws_session).create_function()
    S3apiLambdaTestClient(lws_session).configure_notification()
    world["_skip"] = (
        "lws (consistent with AWS) allows overwriting bucket notification configuration"
    )
