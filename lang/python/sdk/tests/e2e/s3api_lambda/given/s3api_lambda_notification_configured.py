"""
Given: an S3 event notification has been configured to invoke a Lambda function on object "PUT"
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiLambdaTestClient


@given('an S3 event notification has been configured to invoke a Lambda function on object "PUT"')
def s3api_lambda_notification_configured(lws_session):
    S3apiLambdaTestClient(lws_session).create_bucket()
    S3apiLambdaTestClient(lws_session).create_function()
    S3apiLambdaTestClient(lws_session).configure_notification()
