"""Integration tests for AWS fake on DynamoDB (fake returns canned response)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeResponse,
    AwsFakeRule,
)
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestDynamoDbFakeGetItem:
    """Verify fake middleware returns canned response for DynamoDB GetItem."""

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
    def fake_config(self):
        """Create a fake config that returns a canned GetItem response."""
        return AwsFakeConfig(
            service="dynamodb",
            enabled=True,
            rules=[
                AwsFakeRule(
                    operation="get-item",
                    response=AwsFakeResponse(
                        status=200,
                        body={"Item": {"pk": {"S": "faked-id"}, "name": {"S": "faked"}}},
                        content_type="application/x-amz-json-1.0",
                    ),
                ),
            ],
        )

    @pytest.fixture
    def app(self, provider, fake_config):
        """Create DynamoDB app with fake enabled."""
        return create_dynamodb_app(provider, aws_fake=fake_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_fake_returns_canned_get_item(self, client: httpx.AsyncClient):
        """Verify faked GetItem returns canned response."""
        # Arrange
        expected_status = 200
        expected_name = "faked"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "any-key"}}},
        )

        # Assert
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        body = response.json()
        actual_name = body["Item"]["name"]["S"]
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"

    async def test_unfaked_operation_falls_through(self, client: httpx.AsyncClient):
        """Verify unfaked PutItem falls through to real provider."""
        # Arrange
        expected_status = 200

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.ListTables"},
            json={},
        )

        # Assert
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        body = response.json()
        assert "TableNames" in body, f'Expected {"TableNames"!r} to be in {body!r}'
