"""Test client for lambda tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import ROLE_ARN, TEST_FUNC


class LambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("lambda")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_function(self, name=TEST_FUNC):
        try:
            return self._client.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceConflictException":
                return
            raise
