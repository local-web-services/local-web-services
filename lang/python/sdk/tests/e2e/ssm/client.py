"""Test client for ssm tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_PARAM, TEST_VALUE


class SsmTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("ssm")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_param(self, name=TEST_PARAM):
        try:
            self._client.put_parameter(Name=name, Value=TEST_VALUE, Type="String")
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ParameterAlreadyExists":
                return
            raise
