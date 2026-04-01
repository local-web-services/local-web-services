"""Tests for STS AssumeRole session token format."""

from __future__ import annotations

import xml.etree.ElementTree as ET

from fastapi.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


def _parse_session_token(xml_text: str) -> str:
    root = ET.fromstring(xml_text)
    ns = {"sts": _NS}
    return root.find(".//sts:SessionToken", ns).text


class TestAssumeRoleSessionToken:
    def test_session_token_encodes_account_id(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "AssumeRole",
                "RoleArn": "arn:aws:iam::111111111111:role/AgencyBroker",
                "RoleSessionName": "s",
            },
        )
        actual_token = _parse_session_token(resp.text)

        # Assert
        expected_prefix = "lws-acct-111111111111-"
        assert actual_token.startswith(expected_prefix)

    def test_session_token_uses_account_from_arn(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "AssumeRole",
                "RoleArn": "arn:aws:iam::999999999999:role/Admin",
                "RoleSessionName": "s",
            },
        )
        actual_token = _parse_session_token(resp.text)

        # Assert
        expected_prefix = "lws-acct-999999999999-"
        assert actual_token.startswith(expected_prefix)
