"""Tests for IAM ListRoles operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.iam.routes import create_iam_app


def _client() -> TestClient:
    return TestClient(create_iam_app())


def _post(client: TestClient, action: str, params: dict | None = None) -> str:
    data = {"Action": action}
    if params:
        data.update(params)
    resp = client.post("/", data=data)
    return resp.text


class TestListRoles:
    def test_list_empty(self) -> None:
        client = _client()
        xml = _post(client, "ListRoles")

        # Assert
        assert "ListRolesResponse" in xml
        assert "<IsTruncated>false</IsTruncated>" in xml

    def test_list_after_create(self) -> None:
        client = _client()
        role_name = "test-role"
        _post(client, "CreateRole", {"RoleName": role_name, "AssumeRolePolicyDocument": "{}"})
        xml = _post(client, "ListRoles")

        # Assert
        assert role_name in xml
