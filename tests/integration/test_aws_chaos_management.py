"""Integration tests for chaos management API endpoints."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.api.management import create_management_router
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.runtime.orchestrator import Orchestrator


class TestChaosManagementApi:
    """Verify GET/POST /_ldk/chaos endpoints."""

    @pytest.fixture
    def chaos_configs(self):
        """Create chaos configs for two services."""
        return {
            "dynamodb": AwsChaosConfig(),
            "s3": AwsChaosConfig(),
        }

    @pytest.fixture
    def app(self, chaos_configs):
        """Create management app with chaos configs."""
        orchestrator = Orchestrator()
        router = create_management_router(orchestrator, providers={}, chaos_configs=chaos_configs)
        _app = FastAPI()
        _app.include_router(router)
        return _app

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_get_chaos_returns_all_configs(self, client: httpx.AsyncClient):
        """Verify GET /_ldk/chaos returns config for all services."""
        # Arrange
        expected_services = {"dynamodb", "s3"}

        # Act
        response = await client.get("/_ldk/chaos")

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        actual_services = set(body.keys())
        assert actual_services == expected_services
        assert body["dynamodb"]["enabled"] is False

    async def test_post_chaos_enables_service(self, client: httpx.AsyncClient, chaos_configs):
        """Verify POST /_ldk/chaos enables chaos for a service."""
        # Arrange
        expected_enabled = True

        # Act
        response = await client.post(
            "/_ldk/chaos",
            json={"dynamodb": {"enabled": True, "error_rate": 0.5}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        assert "dynamodb" in body["updated"]
        actual_enabled = chaos_configs["dynamodb"].enabled
        assert actual_enabled == expected_enabled
        expected_error_rate = 0.5
        actual_error_rate = chaos_configs["dynamodb"].error_rate
        assert actual_error_rate == expected_error_rate

    async def test_post_chaos_ignores_unknown_service(self, client: httpx.AsyncClient):
        """Verify POST /_ldk/chaos ignores unknown services."""
        # Arrange
        # Act
        response = await client.post(
            "/_ldk/chaos",
            json={"unknown_service": {"enabled": True}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        assert body["updated"] == []
