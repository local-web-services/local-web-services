"""Unit tests for AwsOperationMockMiddleware header-filtered rules."""

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


class TestMockMiddlewareHeaderFilter:
    @pytest.fixture
    def mock_config(self):
        return AwsMockConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsMockRule(
                    operation="get-item",
                    match_headers={"x-custom-tenant": "tenant-a"},
                    response=AwsMockResponse(
                        status=200,
                        body={"Item": {"id": {"S": "tenant-a-mock"}}},
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
        async def handler(request: Request):
            return Response(content='{"real": true}', media_type="application/json")

        return app

    @pytest.fixture
    async def client(self, app):
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_matching_header_returns_mock(self, client):
        # Arrange
        expected_status = 200
        expected_id_value = "tenant-a-mock"

        # Act
        response = await client.post(
            "/",
            headers={
                "X-Amz-Target": "DynamoDB_20120810.GetItem",
                "X-Custom-Tenant": "tenant-a",
            },
            json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_id_value = body["Item"]["id"]["S"]
        assert actual_id_value == expected_id_value

    async def test_missing_header_falls_through(self, client):
        # Arrange
        expected_status = 200
        expected_real = True

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_real = body["real"]
        assert actual_real == expected_real
