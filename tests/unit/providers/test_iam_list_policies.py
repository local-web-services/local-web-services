"""Tests for IAM ListPolicies operation."""

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


class TestListPolicies:
    def test_list_empty(self) -> None:
        client = _client()
        xml = _post(client, "ListPolicies")

        # Assert
        assert "ListPoliciesResponse" in xml

    def test_list_after_create(self) -> None:
        client = _client()
        policy_name = "test-policy"
        _post(client, "CreatePolicy", {"PolicyName": policy_name, "PolicyDocument": "{}"})
        xml = _post(client, "ListPolicies")

        # Assert
        assert policy_name in xml
