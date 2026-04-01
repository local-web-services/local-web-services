"""Integration tests for STS AssumeRole expiration computation."""

from __future__ import annotations

import time
import xml.etree.ElementTree as ET
from datetime import UTC, datetime

import pytest
from starlette.testclient import TestClient

from lws.providers.sts.routes import create_sts_app

_NS = "https://sts.amazonaws.com/doc/2011-06-15/"


@pytest.fixture
def sts_client() -> TestClient:
    return TestClient(create_sts_app())


def _assume_role(sts_client: TestClient, role_arn: str, **extra) -> ET.Element:
    resp = sts_client.post(
        "/",
        data={"Action": "AssumeRole", "RoleArn": role_arn, "RoleSessionName": "s", **extra},
    )
    return ET.fromstring(resp.text)


def _find(root: ET.Element, tag: str) -> str:
    ns = {"sts": _NS}
    return root.find(f".//sts:{tag}", ns).text


class TestAssumeRoleExpiryIntegration:
    def test_expiration_reflects_requested_duration(self, sts_client: TestClient) -> None:
        # Arrange
        before = time.time()

        # Act
        root = _assume_role(
            sts_client,
            "arn:aws:iam::111111111111:role/R",
            DurationSeconds="7200",
        )

        # Assert
        expiration_str = _find(root, "Expiration")
        actual_expiration = (
            datetime.strptime(expiration_str, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=UTC).timestamp()
        )
        expected_expiration = before + 7200
        assert abs(actual_expiration - expected_expiration) < 5

    def test_default_duration_used_when_omitted(self, sts_client: TestClient) -> None:
        # Arrange
        before = time.time()

        # Act
        root = _assume_role(sts_client, "arn:aws:iam::111111111111:role/R")

        # Assert
        expiration_str = _find(root, "Expiration")
        actual_expiration = (
            datetime.strptime(expiration_str, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=UTC).timestamp()
        )
        expected_expiration = before + 3600
        assert abs(actual_expiration - expected_expiration) < 5
