"""Tests for STS AssumeRole operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.sts.routes import create_sts_app


def _client() -> TestClient:
    return TestClient(create_sts_app())


class TestAssumeRole:
    def test_assume_role(self) -> None:
        client = _client()
        role_name = "test-role"
        resp = client.post(
            "/",
            data={
                "Action": "AssumeRole",
                "RoleArn": f"arn:aws:iam::000000000000:role/{role_name}",
                "RoleSessionName": "test-session",
            },
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        xml = resp.text
        assert "AssumeRoleResponse" in xml
        assert "AccessKeyId" in xml
        assert "SecretAccessKey" in xml
        assert "SessionToken" in xml
        assert role_name in xml
