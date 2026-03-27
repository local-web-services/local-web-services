"""Tests that API Gateway proxy routes return 429 when capacity is exhausted."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.apigateway.routes import create_apigateway_management_app


class TestApiGatewayRoutesCapacityExhausted:
    """API Gateway catch-all proxy returns 429 when capacity slots=0."""

    @pytest.mark.asyncio
    async def test_proxy_request_capacity_exhausted(self) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app, _bundle = create_apigateway_management_app(capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 429

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.get("/some/api/path")

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    @pytest.mark.asyncio
    async def test_proxy_post_request_capacity_exhausted(self) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app, _bundle = create_apigateway_management_app(capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 429

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post("/invoke/handler", json={"key": "value"})

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
