"""Unit tests for AwsOperationMockMiddleware fallthrough behavior."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI, Request
from starlette.responses import Response

from lws.providers._shared.aws_operation_mock import (
    AwsMockConfig,
    AwsMockResponse,
    AwsMockRule,
    AwsOperationMockMiddleware,
)


class TestMockMiddlewareFallthrough:
    @pytest.fixture
    def mock_config(self):
        return AwsMockConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsMockRule(
                    operation="get-item",
                    response=AwsMockResponse(
                        status=200,
                        body={"Item": {"id": {"S": "mocked"}}},
                    ),
                )
            ],
        )

    @pytest.fixture
    def app(self, mock_config):
        app = FastAPI()
        app.add_middleware(
            AwsOperationMockMiddleware,
            mock_config=mock_config,
            service="dynamodb",
        )

        @app.post("/")
        async def root_handler(request: Request):
            return Response(content='{"real": true}', media_type="application/json")

        @app.get("/_ldk/health")
        async def ldk_health(request: Request):
            return Response(content='{"status": "ok"}', media_type="application/json")

        return app

    @pytest.fixture
    async def client(self, app):
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_ldk_path_always_falls_through(self, client):
        # Arrange
        expected_status = 200
        expected_health_status = "ok"

        # Act
        response = await client.get("/_ldk/health")

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_health_status = body["status"]
        assert actual_health_status == expected_health_status

    async def test_unknown_operation_falls_through(self, client):
        # Arrange
        expected_status = 200
        expected_real = True

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.DescribeTable"},
            json={"TableName": "TestTable"},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_real = body["real"]
        assert actual_real == expected_real
