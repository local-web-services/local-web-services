"""Tests for STS AssumeRole operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.sts.routes import create_sts_app


def _client() -> TestClient:
    return TestClient(create_sts_app())


class TestAssumeRole:
    def test_assume_role(self) -> None:
        client = _client()
        resp = client.post(
            "/",
            data={
                "Action": "AssumeRole",
                "RoleArn": "arn:aws:iam::000000000000:role/test-role",
                "RoleSessionName": "test-session",
            },
        )
        assert resp.status_code == 200
        xml = resp.text
        assert "AssumeRoleResponse" in xml
        assert "AccessKeyId" in xml
        assert "SecretAccessKey" in xml
        assert "SessionToken" in xml
        assert "test-role" in xml
