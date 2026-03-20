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
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        xml = resp.text
        assert "AssumeRoleResponse" in xml, f'Expected {"AssumeRoleResponse"!r} to be in {xml!r}'
        assert "AccessKeyId" in xml, f'Expected {"AccessKeyId"!r} to be in {xml!r}'
        assert "SecretAccessKey" in xml, f'Expected {"SecretAccessKey"!r} to be in {xml!r}'
        assert "SessionToken" in xml, f'Expected {"SessionToken"!r} to be in {xml!r}'
        assert role_name in xml, f"Expected {role_name!r} to be in {xml!r}"
