"""Integration tests for STS provider endpoints."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import pytest
from starlette.testclient import TestClient

from lws.providers.sts.routes import create_sts_app


def _post_form(client: TestClient, data: dict, headers: dict | None = None) -> tuple[int, str]:
    resp = client.post("/", data=data, headers=headers or {})
    return resp.status_code, resp.text


@pytest.fixture
def sts_client() -> TestClient:
    app = create_sts_app()
    return TestClient(app, raise_server_exceptions=False)


class TestStsEndpoints:
    def test_assume_role_returns_valid_xml_with_credentials(self, sts_client: TestClient) -> None:
        # Arrange
        role_arn = "arn:aws:iam::999999999999:role/test-role"

        # Act
        status, body = _post_form(
            sts_client,
            {
                "Action": "AssumeRole",
                "RoleArn": role_arn,
                "RoleSessionName": "test-session",
            },
        )

        # Assert
        root = ET.fromstring(body)
        ns = {"sts": "https://sts.amazonaws.com/doc/2011-06-15/"}
        actual_access_key = root.findtext(".//sts:AccessKeyId", namespaces=ns)
        actual_session_token = root.findtext(".//sts:SessionToken", namespaces=ns)
        expected_access_key = "ASIALWSLOCALKEY"
        assert status == 200, f"Expected 200, got {status}"
        assert (
            actual_access_key == expected_access_key
        ), f"Expected access key {expected_access_key}, got {actual_access_key}"
        assert actual_session_token is not None, "SessionToken should be present in response"

    def test_assume_role_embeds_account_id_in_session_token(self, sts_client: TestClient) -> None:
        # Arrange
        expected_account_id = "123456789012"
        role_arn = f"arn:aws:iam::{expected_account_id}:role/my-role"

        # Act
        status, body = _post_form(
            sts_client,
            {
                "Action": "AssumeRole",
                "RoleArn": role_arn,
                "RoleSessionName": "sess",
            },
        )

        # Assert
        root = ET.fromstring(body)
        ns = {"sts": "https://sts.amazonaws.com/doc/2011-06-15/"}
        actual_session_token = root.findtext(".//sts:SessionToken", namespaces=ns)
        assert status == 200, f"Expected 200, got {status}"
        assert actual_session_token is not None, "SessionToken must be present"
        assert actual_session_token.startswith(f"lws-acct-{expected_account_id}-"), (
            f"SessionToken should start with lws-acct-{expected_account_id}-, "
            f"got {actual_session_token}"
        )

    def test_assume_role_respects_duration_seconds(self, sts_client: TestClient) -> None:
        # Arrange
        role_arn = "arn:aws:iam::111111111111:role/dur-role"

        # Act
        _, body_short = _post_form(
            sts_client,
            {
                "Action": "AssumeRole",
                "RoleArn": role_arn,
                "RoleSessionName": "short",
                "DurationSeconds": "900",
            },
        )
        _, body_long = _post_form(
            sts_client,
            {
                "Action": "AssumeRole",
                "RoleArn": role_arn,
                "RoleSessionName": "long",
                "DurationSeconds": "43200",
            },
        )

        # Assert
        ns = {"sts": "https://sts.amazonaws.com/doc/2011-06-15/"}
        actual_short_expiration = ET.fromstring(body_short).findtext(
            ".//sts:Expiration", namespaces=ns
        )
        actual_long_expiration = ET.fromstring(body_long).findtext(
            ".//sts:Expiration", namespaces=ns
        )
        assert actual_short_expiration is not None, "Short expiration must be present"
        assert actual_long_expiration is not None, "Long expiration must be present"
        assert actual_short_expiration < actual_long_expiration, (
            f"Short duration ({actual_short_expiration}) should expire before "
            f"long duration ({actual_long_expiration})"
        )

    def test_get_caller_identity_returns_default_account_without_token(
        self, sts_client: TestClient
    ) -> None:
        # Arrange
        expected_account_id = "000000000000"

        # Act
        status, body = _post_form(sts_client, {"Action": "GetCallerIdentity"})

        # Assert
        root = ET.fromstring(body)
        ns = {"sts": "https://sts.amazonaws.com/doc/2011-06-15/"}
        actual_account_id = root.findtext(".//sts:Account", namespaces=ns)
        assert status == 200, f"Expected 200, got {status}"
        assert (
            actual_account_id == expected_account_id
        ), f"Expected default account {expected_account_id}, got {actual_account_id}"

    def test_get_caller_identity_extracts_account_from_session_token(
        self, sts_client: TestClient
    ) -> None:
        # Arrange
        expected_account_id = "555555555555"
        token = f"lws-acct-{expected_account_id}-some-uuid"

        # Act
        status, body = _post_form(
            sts_client,
            {"Action": "GetCallerIdentity"},
            headers={"X-Amz-Security-Token": token},
        )

        # Assert
        root = ET.fromstring(body)
        ns = {"sts": "https://sts.amazonaws.com/doc/2011-06-15/"}
        actual_account_id = root.findtext(".//sts:Account", namespaces=ns)
        assert status == 200, f"Expected 200, got {status}"
        assert (
            actual_account_id == expected_account_id
        ), f"Expected account {expected_account_id}, got {actual_account_id}"
