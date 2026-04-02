"""Test client for s3api_lambda tests."""

from __future__ import annotations

from .constants import FUNC_ARN, ROLE_ARN, TEST_BUCKET, TEST_FUNC


class S3apiLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _s3 = lws_session.client("s3")
        self._s3 = _s3
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._s3.create_bucket(Bucket=name)
        except Exception:
            pass

    def create_function(self, name=TEST_FUNC):
        try:
            self._lambda.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except Exception:
            pass

    def configure_notification(self, bucket=TEST_BUCKET, function_arn=FUNC_ARN):
        self._s3.put_bucket_notification_configuration(
            Bucket=bucket,
            NotificationConfiguration={
                "LambdaFunctionConfigurations": [
                    {
                        "LambdaFunctionArn": function_arn,
                        "Events": ["s3:ObjectCreated:*"],
                    }
                ]
            },
        )
