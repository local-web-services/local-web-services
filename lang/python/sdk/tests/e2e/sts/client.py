"""Test client for STS e2e tests."""

from __future__ import annotations

import boto3

from .constants import TEST_ROLE_ARN, TEST_SESSION_NAME


class StsTestClient:
    def __init__(self, lws_session, session_token: str | None = None):
        self._lws_session = lws_session
        self._port = lws_session._ports["sts"]  # pylint: disable=protected-access
        self._client = self._make_client(session_token)

    def _make_client(self, session_token: str | None = None):
        return boto3.client(
            "sts",
            endpoint_url=f"http://127.0.0.1:{self._port}",
            region_name="us-east-1",
            aws_access_key_id="test",
            aws_secret_access_key="test",
            aws_session_token=session_token,
        )

    def assume_role(self, role_arn: str = TEST_ROLE_ARN, session_name: str = TEST_SESSION_NAME):
        return self._client.assume_role(RoleArn=role_arn, RoleSessionName=session_name)

    def get_caller_identity(self, session_token: str | None = None):
        client = self._make_client(session_token) if session_token else self._client
        return client.get_caller_identity()
