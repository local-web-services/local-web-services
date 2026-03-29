"""Test client for secretsmanager tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_SECRET, TEST_VALUE


class SecretsmanagerTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("secretsmanager")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_secret(self, name=TEST_SECRET):
        try:
            self._client.create_secret(Name=name, SecretString=TEST_VALUE)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceExistsException":
                return
            raise
