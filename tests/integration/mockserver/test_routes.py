"""Integration tests for mock server HTTP routes."""

from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.mockserver.models import (
    MatchCriteria,
    MockResponse,
    MockServerConfig,
    RouteRule,
)
from lws.providers.mockserver.routes import create_mockserver_app


@pytest.fixture
def simple_config() -> MockServerConfig:
    """Create a simple mock server config with one route."""
    route = RouteRule(
        path="/v1/users/{user_id}",
        method="GET",
        responses=[
            (MatchCriteria(), MockResponse(status=200, body={"id": "{{path.user_id}}"})),
        ],
    )
    return MockServerConfig(name="test-api", routes=[route])


@pytest.fixture
def conditional_config() -> MockServerConfig:
    """Create a mock server config with conditional routing."""
    route = RouteRule(
        path="/v1/payments/{id}",
        method="GET",
        responses=[
            (
                MatchCriteria(path_params={"id": r"pay_expired_.*"}),
                MockResponse(status=410, body={"error": "payment_expired"}),
            ),
            (
                MatchCriteria(headers={"X-Api-Version": "2"}),
                MockResponse(status=200, body={"version": 2}),
            ),
            (MatchCriteria(), MockResponse(status=200, body={"version": 1})),
        ],
    )
    return MockServerConfig(name="payment-api", routes=[route])


class TestBasicRouting:
    async def test_get_with_path_param(self, simple_config):
        # Arrange
        app = create_mockserver_app(simple_config)
        expected_id = "usr_123"

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/v1/users/usr_123")

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        actual_id = response.json()["id"]
        assert actual_id == expected_id

    async def test_no_matching_route(self, simple_config):
        # Arrange
        app = create_mockserver_app(simple_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/v1/nonexistent")

        # Assert
        expected_status = 404
        assert response.status_code == expected_status


class TestConditionalRouting:
    async def test_path_param_regex(self, conditional_config):
        # Arrange
        app = create_mockserver_app(conditional_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/v1/payments/pay_expired_abc")

        # Assert
        expected_status = 410
        assert response.status_code == expected_status

    async def test_header_match(self, conditional_config):
        # Arrange
        app = create_mockserver_app(conditional_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/v1/payments/pay_normal", headers={"X-Api-Version": "2"})

        # Assert
        expected_version = 2
        actual_version = response.json()["version"]
        assert actual_version == expected_version

    async def test_catch_all_fallthrough(self, conditional_config):
        # Arrange
        app = create_mockserver_app(conditional_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/v1/payments/pay_normal")

        # Assert
        expected_version = 1
        actual_version = response.json()["version"]
        assert actual_version == expected_version


class TestManagementEndpoints:
    async def test_get_config(self, simple_config):
        # Arrange
        app = create_mockserver_app(simple_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.get("/_mock/config")

        # Assert
        expected_name = "test-api"
        actual_name = response.json()["name"]
        assert actual_name == expected_name

    async def test_set_chaos(self, simple_config):
        # Arrange
        app = create_mockserver_app(simple_config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.post("/_mock/chaos", json={"enabled": True, "error_rate": 0.5})

        # Assert
        assert response.json()["chaos"]["enabled"] is True
        expected_error_rate = 0.5
        actual_error_rate = response.json()["chaos"]["error_rate"]
        assert actual_error_rate == expected_error_rate


class TestPostWithBody:
    async def test_post_route(self):
        # Arrange
        route = RouteRule(
            path="/v1/orders",
            method="POST",
            responses=[
                (MatchCriteria(), MockResponse(status=201, body={"created": True})),
            ],
        )
        config = MockServerConfig(name="order-api", routes=[route])
        app = create_mockserver_app(config)

        # Act
        async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
            response = await client.post("/v1/orders", json={"item": "widget"})

        # Assert
        expected_status = 201
        assert response.status_code == expected_status
        assert response.json()["created"] is True
