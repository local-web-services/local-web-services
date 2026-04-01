"""Tests for STS AssumeRole expiration computation."""

from __future__ import annotations

import time
import xml.etree.ElementTree as ET

from fastapi.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


def _assume_role(
    client: TestClient, role_arn: str = "arn:aws:iam::111111111111:role/R", **extra
) -> str:
    resp = client.post(
        "/",
        data={"Action": "AssumeRole", "RoleArn": role_arn, "RoleSessionName": "s", **extra},
    )
    return resp.text


def _parse_expiration(xml_text: str) -> float:
    from datetime import UTC, datetime

    root = ET.fromstring(xml_text)
    ns = {"sts": _NS}
    expiration_str = root.find(".//sts:Expiration", ns).text
    dt = datetime.strptime(expiration_str, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=UTC)
    return dt.timestamp()


class TestAssumeRoleExpiry:
    def test_expiration_reflects_requested_duration(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())
        before = time.time()

        # Act
        xml_text = _assume_role(client, DurationSeconds="7200")

        # Assert
        actual_expiration = _parse_expiration(xml_text)
        expected_expiration = before + 7200
        assert abs(actual_expiration - expected_expiration) < 5

    def test_default_duration_used_when_omitted(self) -> None:
        # Arrange
        client = TestClient(create_sts_app())
        before = time.time()

        # Act
        xml_text = _assume_role(client)

        # Assert
        actual_expiration = _parse_expiration(xml_text)
        expected_expiration = before + 3600
        assert abs(actual_expiration - expected_expiration) < 5
