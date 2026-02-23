"""Integration tests for AWS mock header filtering."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers._shared.aws_operation_mock import (
    AwsMockConfig,
    AwsMockResponse,
    AwsMockRule,
)
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestMockHeaderFilter:
    """Verify mock header-based filtering activates only with correct headers."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create DynamoDB provider."""
        p = SqliteDynamoProvider(
            data_dir=tmp_path,
            tables=[
                TableConfig(
                    table_name="TestTable",
                    key_schema=KeySchema(partition_key=KeyAttribute(name="pk", type="S")),
                )
            ],
        )
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def mock_config(self):
        """Create a mock config with header filter on GetItem."""
        return AwsMockConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsMockRule(
                    operation="get-item",
                    match_headers={"x-custom-test": "special-case"},
                    response=AwsMockResponse(
                        status=200,
                        body={"Item": {"pk": {"S": "filtered-mock"}}},
                        content_type="application/x-amz-json-1.0",
                    ),
                ),
            ],
        )

    @pytest.fixture
    def app(self, provider, mock_config):
        """Create DynamoDB app with header-filtered mock."""
        return create_dynamodb_app(provider, aws_mock=mock_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_matching_header_returns_mock(self, client: httpx.AsyncClient):
        """Verify GetItem with matching header returns mocked response."""
        # Arrange
        expected_pk = "filtered-mock"

        # Act
        response = await client.post(
            "/",
            headers={
                "X-Amz-Target": "DynamoDB_20120810.GetItem",
                "x-custom-test": "special-case",
            },
            json={"TableName": "TestTable", "Key": {"pk": {"S": "any"}}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        actual_pk = body["Item"]["pk"]["S"]
        assert actual_pk == expected_pk

    async def test_missing_header_falls_through(self, client: httpx.AsyncClient):
        """Verify GetItem without matching header falls through to real provider."""
        # Arrange — no x-custom-test header

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "real-key"}}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        body = response.json()
        # Real provider returns empty Item (key doesn't exist)
        actual_item = body.get("Item")
        assert actual_item is None or "pk" not in actual_item

    async def test_wrong_header_value_falls_through(self, client: httpx.AsyncClient):
        """Verify GetItem with wrong header value falls through to real provider."""
        # Arrange

        # Act
        response = await client.post(
            "/",
            headers={
                "X-Amz-Target": "DynamoDB_20120810.GetItem",
                "x-custom-test": "wrong-value",
            },
            json={"TableName": "TestTable", "Key": {"pk": {"S": "real-key"}}},
        )

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
