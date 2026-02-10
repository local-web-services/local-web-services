"""Tests for API Gateway V2 ListIntegrations operation."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.apigateway.routes import create_apigateway_management_app


def _client() -> TestClient:
    return TestClient(create_apigateway_management_app())


class TestListIntegrations:
    def test_list_empty(self) -> None:
        client = _client()
        resp = client.post("/v2/apis", content=json.dumps({"name": "test-api"}))
        api_id = resp.json()["apiId"]

        resp = client.get(f"/v2/apis/{api_id}/integrations")
        assert resp.status_code == 200
        assert resp.json()["items"] == []

    def test_list_after_create(self) -> None:
        client = _client()
        resp = client.post("/v2/apis", content=json.dumps({"name": "test-api"}))
        api_id = resp.json()["apiId"]

        client.post(
            f"/v2/apis/{api_id}/integrations",
            content=json.dumps({"integrationType": "AWS_PROXY", "integrationUri": "test"}),
        )
        resp = client.get(f"/v2/apis/{api_id}/integrations")
        assert len(resp.json()["items"]) == 1
