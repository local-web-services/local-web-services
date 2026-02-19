"""Integration test for Lambda Function URL CORS handling."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_function_url.routes import create_lambda_function_url_app

from .conftest import MockCompute


@pytest.fixture
def cors_mock_compute():
    return MockCompute(response={"statusCode": 200, "body": "ok"})


@pytest.fixture
def cors_app(cors_mock_compute):
    cors_config = {
        "AllowOrigins": ["https://example.com"],
        "AllowMethods": ["GET", "POST"],
        "AllowHeaders": ["content-type", "authorization"],
        "MaxAge": 3600,
    }
    return create_lambda_function_url_app("cors-function", cors_mock_compute, cors_config)


@pytest.fixture
async def cors_client(cors_app):
    transport = httpx.ASGITransport(app=cors_app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestFunctionUrlCors:
    async def test_preflight_options_returns_204(self, cors_client: httpx.AsyncClient):
        # Arrange
        origin = "https://example.com"

        # Act
        resp = await cors_client.options("/", headers={"origin": origin})

        # Assert
        expected_status = 204
        actual_status = resp.status_code
        assert actual_status == expected_status

    async def test_preflight_includes_cors_headers(self, cors_client: httpx.AsyncClient):
        # Arrange
        expected_origin = "https://example.com"

        # Act
        resp = await cors_client.options(
            "/",
            headers={"origin": expected_origin},
        )

        # Assert
        actual_origin = resp.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin
        assert "access-control-allow-methods" in resp.headers

    async def test_regular_request_includes_cors_headers(self, cors_client: httpx.AsyncClient):
        # Arrange
        expected_origin = "https://example.com"

        # Act
        resp = await cors_client.get(
            "/data",
            headers={"origin": expected_origin},
        )

        # Assert
        actual_origin = resp.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin

    async def test_max_age_header(self, cors_client: httpx.AsyncClient):
        # Arrange
        expected_max_age = "3600"

        # Act
        resp = await cors_client.options(
            "/",
            headers={"origin": "https://example.com"},
        )

        # Assert
        actual_max_age = resp.headers.get("access-control-max-age")
        assert actual_max_age == expected_max_age

    async def test_no_cors_config_no_headers(self, client: httpx.AsyncClient):
        # Arrange
        path = "/"

        # Act
        resp = await client.get(path)

        # Assert
        assert "access-control-allow-origin" not in resp.headers
