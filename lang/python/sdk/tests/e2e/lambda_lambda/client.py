"""Test client for lambda_lambda tests."""

from __future__ import annotations

from .constants import ROLE_ARN


class LambdaLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("lambda")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_function(self, name):
        self._client.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
