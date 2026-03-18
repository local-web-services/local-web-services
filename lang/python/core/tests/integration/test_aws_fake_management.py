"""Integration tests for AWS fake management API endpoints."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.api.management import create_management_router
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeResponse,
    AwsFakeRule,
)
from lws.runtime.orchestrator import Orchestrator


class TestAwsFakeManagementApi:
    """Verify GET/POST /_ldk/aws-fake endpoints."""

    @pytest.fixture
    def fake_configs(self):
        """Create fake configs for two services."""
        return {
            "dynamodb": AwsFakeConfig(
                service="dynamodb",
                enabled=True,
                rules=[
                    AwsFakeRule(
                        operation="get-item",
                        response=AwsFakeResponse(status=200, body={"Item": {}}),
                    ),
                ],
            ),
            "s3": AwsFakeConfig(service="s3", enabled=False),
        }

    @pytest.fixture
    def app(self, fake_configs):
        """Create management app with fake configs."""
        orchestrator = Orchestrator()
        router = create_management_router(orchestrator, providers={}, aws_fake_configs=fake_configs)
        _app = FastAPI()
        _app.include_router(router)
        return _app

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_get_aws_fake_returns_all_configs(self, client: httpx.AsyncClient):
        """Verify GET /_ldk/aws-fake returns config for all services."""
        # Arrange
        expected_services = {"dynamodb", "s3"}

        # Act
        response = await client.get("/_ldk/aws-fake")

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        actual_services = set(body.keys())
        assert actual_services == expected_services
        assert body["dynamodb"]["enabled"] is True
        assert body["s3"]["enabled"] is False

    async def test_get_aws_fake_includes_rules(self, client: httpx.AsyncClient):
        """Verify GET /_ldk/aws-fake includes rule details."""
        # Arrange
        expected_operation = "get-item"

        # Act
        response = await client.get("/_ldk/aws-fake")

        # Assert
        body = response.json()
        actual_operation = body["dynamodb"]["rules"][0]["operation"]
        assert actual_operation == expected_operation

    async def test_post_aws_fake_disables_service(self, client: httpx.AsyncClient, fake_configs):
        """Verify POST /_ldk/aws-fake can disable a service."""
        # Arrange
        expected_enabled = False

        # Act
        response = await client.post(
            "/_ldk/aws-fake",
            json={"dynamodb": {"enabled": False}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        assert "dynamodb" in body["updated"]
        actual_enabled = fake_configs["dynamodb"].enabled
        assert actual_enabled == expected_enabled

    async def test_post_aws_fake_ignores_unknown_service(self, client: httpx.AsyncClient):
        """Verify POST /_ldk/aws-fake ignores unknown services."""
        # Arrange
        # Act
        response = await client.post(
            "/_ldk/aws-fake",
            json={"unknown_service": {"enabled": True}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        assert body["updated"] == []
