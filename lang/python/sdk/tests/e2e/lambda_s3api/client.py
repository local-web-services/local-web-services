"""Test client for lambda_s3api tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_BUCKET, TEST_FUNC


class LambdaS3apiTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _s3 = lws_session.client("s3")
        self._s3 = _s3

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_bucket(self, name=TEST_BUCKET):
        self._s3.create_bucket(Bucket=name)
