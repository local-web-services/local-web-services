"""Integration tests for AWS chaos injection on DynamoDB (JSON format)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsErrorSpec
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestDynamoDbChaosJsonFormat:
    """Verify chaos middleware injects JSON-formatted AWS errors on DynamoDB."""

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
    def chaos_config(self):
        """Create a chaos config that always injects errors."""
        return AwsChaosConfig(
            enabled=True,
            error_rate=1.0,
            errors=[
                AwsErrorSpec(
                    type="ResourceNotFoundException",
                    message="Chaos: table not found",
                    weight=1.0,
                )
            ],
        )

    @pytest.fixture
    def app(self, provider, chaos_config):
        """Create DynamoDB app with chaos enabled."""
        return create_dynamodb_app(provider, chaos=chaos_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_chaos_injects_json_error(self, client: httpx.AsyncClient):
        """Verify chaos injects a properly formatted JSON AWS error."""
        # Arrange
        expected_status = 404
        expected_type = "ResourceNotFoundException"
        expected_message = "Chaos: table not found"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.Scan"},
            json={"TableName": "TestTable"},
        )

        # Assert
        assert response.status_code == expected_status
        body = response.json()
        actual_type = body["__type"]
        assert actual_type == expected_type
        actual_message = body["message"]
        assert actual_message == expected_message

    async def test_chaos_disabled_passes_through(
        self, provider, client: httpx.AsyncClient, chaos_config
    ):
        """Verify requests pass through when chaos is disabled."""
        # Arrange
        chaos_config.enabled = False
        expected_status = 200

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.ListTables"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status

    async def test_chaos_latency_does_not_break_response(self, provider, tmp_path):
        """Verify latency injection still returns a valid response."""
        # Arrange
        chaos = AwsChaosConfig(
            enabled=True,
            latency_min_ms=1,
            latency_max_ms=2,
        )
        app = create_dynamodb_app(provider, chaos=chaos)
        transport = httpx.ASGITransport(app=app)
        expected_status = 200

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            response = await c.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.ListTables"},
                json={},
            )

        # Assert
        assert response.status_code == expected_status
