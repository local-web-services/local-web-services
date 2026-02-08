"""Unit tests for the GET /_ldk/resources endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from ldk.api.management import create_management_router
from ldk.runtime.orchestrator import Orchestrator

from ._helpers import FakeProvider


@pytest.fixture
def _resource_metadata():
    return {
        "port": 3000,
        "services": {
            "apigateway": {
                "port": 3000,
                "resources": [
                    {
                        "name": "default",
                        "path": "/orders",
                        "method": "GET",
                        "handler": "getOrders",
                    }
                ],
            },
            "dynamodb": {
                "port": 3001,
                "resources": [{"name": "MyTable"}],
            },
            "sqs": {
                "port": 3002,
                "resources": [
                    {
                        "name": "MyQueue",
                        "queue_url": "http://localhost:3002/000000000000/MyQueue",
                    }
                ],
            },
            "stepfunctions": {
                "port": 3006,
                "resources": [
                    {
                        "name": "MyStateMachine",
                        "arn": "arn:aws:states:us-east-1:000000000000:stateMachine:MyStateMachine",
                    }
                ],
            },
        },
    }


@pytest.fixture
def client(_resource_metadata):
    orchestrator = Orchestrator()
    orchestrator._running = True
    providers = {"dynamodb": FakeProvider("dynamodb")}
    orchestrator._providers = providers

    router = create_management_router(
        orchestrator=orchestrator,
        compute_providers={},
        providers=providers,
        resource_metadata=_resource_metadata,
    )
    app = FastAPI()
    app.include_router(router)
    return TestClient(app)


class TestResourcesEndpoint:
    """Tests for GET /_ldk/resources."""

    def test_returns_200(self, client):
        resp = client.get("/_ldk/resources")
        assert resp.status_code == 200

    def test_returns_port(self, client):
        data = client.get("/_ldk/resources").json()
        assert data["port"] == 3000

    def test_returns_services(self, client):
        data = client.get("/_ldk/resources").json()
        assert "apigateway" in data["services"]
        assert "dynamodb" in data["services"]
        assert "sqs" in data["services"]
        assert "stepfunctions" in data["services"]

    def test_apigateway_has_route_details(self, client):
        data = client.get("/_ldk/resources").json()
        apigw = data["services"]["apigateway"]
        assert apigw["port"] == 3000
        assert len(apigw["resources"]) == 1
        route = apigw["resources"][0]
        assert route["path"] == "/orders"
        assert route["method"] == "GET"
        assert route["handler"] == "getOrders"

    def test_dynamodb_has_port_and_resources(self, client):
        data = client.get("/_ldk/resources").json()
        dynamo = data["services"]["dynamodb"]
        assert dynamo["port"] == 3001
        assert len(dynamo["resources"]) == 1
        assert dynamo["resources"][0]["name"] == "MyTable"

    def test_sqs_has_queue_url(self, client):
        data = client.get("/_ldk/resources").json()
        sqs = data["services"]["sqs"]
        assert sqs["resources"][0]["queue_url"].startswith("http://")

    def test_stepfunctions_has_arn(self, client):
        data = client.get("/_ldk/resources").json()
        sfn = data["services"]["stepfunctions"]
        assert "arn:" in sfn["resources"][0]["arn"]

    def test_empty_metadata(self):
        """When no resource_metadata is provided, returns empty dict."""
        orchestrator = Orchestrator()
        orchestrator._running = True
        orchestrator._providers = {}
        router = create_management_router(
            orchestrator=orchestrator,
            compute_providers={},
            providers={},
        )
        app = FastAPI()
        app.include_router(router)
        c = TestClient(app)
        data = c.get("/_ldk/resources").json()
        assert data == {}
