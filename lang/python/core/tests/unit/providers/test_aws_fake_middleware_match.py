"""Unit tests for AwsOperationFakeMiddleware matching logic."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI, Request
from starlette.responses import Response

from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeResponse,
    AwsFakeRule,
    AwsOperationFakeMiddleware,
)


class TestFakeMiddlewareMatch:
    @pytest.fixture
    def fake_config(self):
        return AwsFakeConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsFakeRule(
                    operation="get-item",
                    response=AwsFakeResponse(
                        status=200,
                        body={"Item": {"id": {"S": "faked"}}},
                    ),
                )
            ],
        )

    @pytest.fixture
    def app(self, fake_config):
        app = FastAPI()
        app.add_middleware(
            AwsOperationFakeMiddleware,
            fake_config=fake_config,
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

    async def test_matching_operation_returns_fake(self, client):
        # Arrange
        expected_status = 200
        expected_id_value = "faked"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
        )

        # Assert
        assert response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {response.status_code!r}"
        )
        body = response.json()
        actual_id_value = body["Item"]["id"]["S"]
        assert actual_id_value == expected_id_value, (
            f"Expected {expected_id_value!r} but got {actual_id_value!r}"
        )

    async def test_non_matching_operation_falls_through(self, client):
        # Arrange
        expected_status = 200
        expected_real = True

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.Scan"},
            json={"TableName": "TestTable"},
        )

        # Assert
        assert response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {response.status_code!r}"
        )
        body = response.json()
        actual_real = body["real"]
        assert actual_real == expected_real, f"Expected {expected_real!r} but got {actual_real!r}"
