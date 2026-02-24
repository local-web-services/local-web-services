"""Tests for API Gateway V2 ListRoutes operation."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.apigateway.routes import create_apigateway_management_app


def _client() -> TestClient:
    return TestClient(create_apigateway_management_app())


class TestListRoutes:
    def test_list_empty(self) -> None:
        client = _client()
        # Create an API first
        resp = client.post("/v2/apis", content=json.dumps({"name": "test-api"}))
        api_id = resp.json()["apiId"]

        resp = client.get(f"/v2/apis/{api_id}/routes")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert resp.json()["items"] == []

    def test_list_after_create(self) -> None:
        client = _client()
        resp = client.post("/v2/apis", content=json.dumps({"name": "test-api"}))
        api_id = resp.json()["apiId"]

        client.post(
            f"/v2/apis/{api_id}/routes",
            content=json.dumps({"routeKey": "GET /items"}),
        )
        resp = client.get(f"/v2/apis/{api_id}/routes")

        # Assert
        expected_count = 1
        assert len(resp.json()["items"]) == expected_count
