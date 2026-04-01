"""Integration tests: CloudTrail middleware captures DynamoDB calls."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers.cloudtrail.provider import CloudTrailProvider
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestCloudTrailMiddlewareCapturesDynamoDB:
    """Middleware captures DynamoDB operations through the ASGI stack."""

    @pytest.fixture
    async def dynamo_provider(self, tmp_path: Path):
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
    def cloudtrail_provider(self):
        return CloudTrailProvider()

    @pytest.fixture
    async def client(self, dynamo_provider, cloudtrail_provider):
        app = create_dynamodb_app(dynamo_provider, cloudtrail_provider=cloudtrail_provider)
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c, cloudtrail_provider

    async def test_create_table_event_captured(self, client) -> None:
        # Arrange
        http_client, ct_provider = client
        headers = {
            "x-amz-target": "DynamoDB_20120810.CreateTable",
            "Content-Type": "application/x-amz-json-1.0",
        }
        body = {
            "TableName": "NewTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
            "BillingMode": "PAY_PER_REQUEST",
        }

        # Act
        response = await http_client.post("/", headers=headers, json=body)

        # Assert
        expected_status = 200
        assert response.status_code == expected_status
        events = ct_provider._buffer.snapshot()
        expected_count = 1
        assert len(events) >= expected_count
        actual_event_name = events[0]["eventName"]
        expected_event_name = "CreateTable"
        assert actual_event_name == expected_event_name
