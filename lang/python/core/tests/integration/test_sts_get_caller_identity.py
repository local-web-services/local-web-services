"""Integration tests for STS GetCallerIdentity account ID extraction."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import pytest
from starlette.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


@pytest.fixture
def sts_client() -> TestClient:
    return TestClient(create_sts_app())


def _get_caller_identity(sts_client: TestClient, security_token: str = "") -> str:
    headers = {}
    if security_token:
        headers["X-Amz-Security-Token"] = security_token
    resp = sts_client.post("/", data={"Action": "GetCallerIdentity"}, headers=headers)
    root = ET.fromstring(resp.text)
    ns = {"sts": _NS}
    return root.find(".//sts:Account", ns).text


class TestGetCallerIdentityIntegration:
    def test_account_derived_from_session_token(self, sts_client: TestClient) -> None:
        # Arrange
        session_token = "lws-acct-111111111111-test-uuid"

        # Act
        actual_account = _get_caller_identity(sts_client, security_token=session_token)

        # Assert
        expected_account = "111111111111"
        assert actual_account == expected_account

    def test_default_account_when_no_session_token(self, sts_client: TestClient) -> None:
        # Arrange / Act
        actual_account = _get_caller_identity(sts_client)

        # Assert
        expected_account = "000000000000"
        assert actual_account == expected_account
