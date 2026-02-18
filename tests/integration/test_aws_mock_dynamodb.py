"""Integration tests for AWS mock on DynamoDB (mock returns canned response)."""

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


class TestDynamoDbMockGetItem:
    """Verify mock middleware returns canned response for DynamoDB GetItem."""

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
        """Create a mock config that returns a canned GetItem response."""
        return AwsMockConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsMockRule(
                    operation="get-item",
                    response=AwsMockResponse(
                        status=200,
                        body={"Item": {"pk": {"S": "mocked-id"}, "name": {"S": "mocked"}}},
                        content_type="application/x-amz-json-1.0",
                    ),
                ),
            ],
        )

    @pytest.fixture
    def app(self, provider, mock_config):
        """Create DynamoDB app with mock enabled."""
        return create_dynamodb_app(provider, aws_mock=mock_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_mock_returns_canned_get_item(self, client: httpx.AsyncClient):
        """Verify mocked GetItem returns canned response."""
        # Arrange
        expected_status = 200
        expected_name = "mocked"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "any-key"}}},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_name = body["Item"]["name"]["S"]
        assert actual_name == expected_name

    async def test_unmocked_operation_falls_through(self, client: httpx.AsyncClient):
        """Verify unmocked PutItem falls through to real provider."""
        # Arrange
        expected_status = 200

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.ListTables"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        assert "TableNames" in body
