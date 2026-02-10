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
        resp = await client.post(
            "/",
            json={},
            headers={"X-Amz-Target": "DynamoDB_20120810.DescribeContinuousBackups"},
        )
        assert resp.status_code == 400
        body = resp.json()
        assert body["__type"] == "UnknownOperationException"
        assert "lws" in body["message"]
        assert "DynamoDB" in body["message"]
        assert "DescribeContinuousBackups" in body["message"]
