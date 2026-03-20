"""Tests for DynamoDB stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestDynamoDbStubOperations:
    """Test DynamoDB returns proper errors for unknown operations."""

    @pytest.fixture
    def client(self, tmp_path):
        """Create an HTTP client for the DynamoDB app."""
        provider = SqliteDynamoProvider(data_dir=tmp_path, tables=[])
        app = create_dynamodb_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_operation_returns_error(self, client):
        """Test that unknown operations return HTTP 400 with UnknownOperationException."""
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"

        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"X-Amz-Target": "DynamoDB_20120810.SomeUnknownOp"},
        )

        # Assert
        assert resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        )
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )
        assert "lws" in body["message"], f'Expected {"lws"!r} to be in {body["message"]!r}'
        assert "DynamoDB" in body["message"], (
            f'Expected {"DynamoDB"!r} to be in {body["message"]!r}'
        )
        assert "SomeUnknownOp" in body["message"], (
            f'Expected {"SomeUnknownOp"!r} to be in {body["message"]!r}'
        )
