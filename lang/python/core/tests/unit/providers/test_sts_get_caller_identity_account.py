"""Tests for STS GetCallerIdentity account ID extraction."""

from __future__ import annotations

import xml.etree.ElementTree as ET

from fastapi.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


def _get_caller_identity(client: TestClient, security_token: str = "") -> str:
    headers = {}
    if security_token:
        headers["X-Amz-Security-Token"] = security_token
    resp = client.post(
        "/",
        data={"Action": "GetCallerIdentity"},
        headers=headers,
    )
    root = ET.fromstring(resp.text)
    ns = {"sts": _NS}
    return root.find(".//sts:Account", ns).text


class TestGetCallerIdentityAccount:
    def test_account_derived_from_session_token(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())
        session_token = "lws-acct-111111111111-some-uuid"

        # Act
        actual_account = _get_caller_identity(client, security_token=session_token)

        # Assert
        expected_account = "111111111111"
        assert actual_account == expected_account

    def test_default_account_when_no_session_token(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())

        # Act
        actual_account = _get_caller_identity(client)

        # Assert
        expected_account = "000000000000"
        assert actual_account == expected_account
