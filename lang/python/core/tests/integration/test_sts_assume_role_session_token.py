"""Integration tests for STS AssumeRole session token format."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import pytest
from starlette.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


@pytest.fixture
def sts_client() -> TestClient:
    return TestClient(create_sts_app())


def _parse_session_token(sts_client: TestClient, role_arn: str) -> str:
    resp = sts_client.post(
        "/",
        data={"Action": "AssumeRole", "RoleArn": role_arn, "RoleSessionName": "s"},
    )
    root = ET.fromstring(resp.text)
    ns = {"sts": _NS}
    return root.find(".//sts:SessionToken", ns).text


class TestAssumeRoleSessionTokenIntegration:
    def test_session_token_encodes_account_id(self, sts_client: TestClient) -> None:
        # Arrange / Act
        role_arn = "arn:aws:iam::111111111111:role/AgencyBroker"
        actual_token = _parse_session_token(sts_client, role_arn)

        # Assert
        expected_prefix = "lws-acct-111111111111-"
        assert actual_token.startswith(expected_prefix)
