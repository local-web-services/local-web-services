"""Unit tests for the GET /_ldk/resources endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator

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
        providers=providers,
        resource_metadata=_resource_metadata,
    )
    app = FastAPI()
    app.include_router(router)
    return TestClient(app)


class TestResourcesEndpoint:
    """Tests for GET /_ldk/resources."""

    def test_returns_200(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.get("/_ldk/resources")

        # Assert
        assert resp.status_code == expected_status_code

    def test_returns_port(self, client):
        # Arrange
        expected_port = 3000

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        actual_port = data["port"]
        assert actual_port == expected_port

    def test_returns_services(self, client):
        # Arrange
        expected_apigateway = "apigateway"
        expected_dynamodb = "dynamodb"
        expected_sqs = "sqs"
        expected_stepfunctions = "stepfunctions"

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        actual_services = data["services"]
        assert expected_apigateway in actual_services
        assert expected_dynamodb in actual_services
        assert expected_sqs in actual_services
        assert expected_stepfunctions in actual_services

    def test_apigateway_has_route_details(self, client):
        # Arrange
        expected_port = 3000
        expected_resource_count = 1
        expected_path = "/orders"
        expected_method = "GET"
        expected_handler = "getOrders"

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        apigw = data["services"]["apigateway"]
        actual_port = apigw["port"]
        assert actual_port == expected_port
        actual_resource_count = len(apigw["resources"])
        assert actual_resource_count == expected_resource_count
        route = apigw["resources"][0]
        actual_path = route["path"]
        assert actual_path == expected_path
        actual_method = route["method"]
        assert actual_method == expected_method
        actual_handler = route["handler"]
        assert actual_handler == expected_handler

    def test_dynamodb_has_port_and_resources(self, client):
        # Arrange
        expected_port = 3001
        expected_resource_count = 1
        expected_table_name = "MyTable"

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        dynamo = data["services"]["dynamodb"]
        actual_port = dynamo["port"]
        assert actual_port == expected_port
        actual_resource_count = len(dynamo["resources"])
        assert actual_resource_count == expected_resource_count
        actual_table_name = dynamo["resources"][0]["name"]
        assert actual_table_name == expected_table_name

    def test_sqs_has_queue_url(self, client):
        # Arrange
        expected_url_prefix = "http://"

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        sqs = data["services"]["sqs"]
        actual_queue_url = sqs["resources"][0]["queue_url"]
        assert actual_queue_url.startswith(expected_url_prefix)

    def test_stepfunctions_has_arn(self, client):
        # Arrange
        expected_arn_prefix = "arn:"

        # Act
        data = client.get("/_ldk/resources").json()

        # Assert
        sfn = data["services"]["stepfunctions"]
        actual_arn = sfn["resources"][0]["arn"]
        assert expected_arn_prefix in actual_arn

    def test_empty_metadata(self):
        """When no resource_metadata is provided, returns empty dict."""
        # Arrange
        expected_data = {}
        orchestrator = Orchestrator()
        orchestrator._running = True
        orchestrator._providers = {}
        router = create_management_router(
            orchestrator=orchestrator,
            providers={},
        )
        app = FastAPI()
        app.include_router(router)
        c = TestClient(app)

        # Act
        actual_data = c.get("/_ldk/resources").json()

        # Assert
        assert actual_data == expected_data
