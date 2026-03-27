"""Tests for put_targets validation — rejection when DynamoDB table is missing or not ACTIVE."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.interfaces import TableConfig
from lws.interfaces.key_value_store import KeyAttribute, KeySchema
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.eventbridge.provider import EventBridgeProvider, RuleConfig
from lws.providers.eventbridge.routes import create_eventbridge_app


async def _started_provider() -> EventBridgeProvider:
    provider = EventBridgeProvider(
        rules=[
            RuleConfig(
                rule_name="my-rule",
                event_bus_name="default",
                event_pattern={"source": ["test.source"]},
            )
        ]
    )
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


def _put_targets_body(table_name: str) -> dict:
    return {
        "Rule": "my-rule",
        "Targets": [
            {
                "Id": "ddb-target",
                "Arn": f"arn:aws:dynamodb:us-east-1:000000000000:table/{table_name}",
            }
        ],
    }


class TestPutTargetsDynamodbTableMissing:
    """put_targets is rejected when the DynamoDB table does not exist."""

    @pytest.mark.asyncio
    async def test_put_targets_rejected_when_dynamodb_table_does_not_exist(self, tmp_path) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "DynamoDB table does not exist"
        dynamodb_provider = SqliteDynamoProvider(data_dir=tmp_path / "dynamodb")
        provider = await _started_provider()
        app = create_eventbridge_app(provider, dynamodb_provider=dynamodb_provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                content=json.dumps(_put_targets_body("nonexistent-table")),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        assert expected_error_fragment in actual_body.get(
            "Error", ""
        ), f"Expected {expected_error_fragment!r} to be in {actual_body!r}"

    @pytest.mark.asyncio
    async def test_put_targets_rejected_when_dynamodb_table_is_creating(self, tmp_path) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        expected_table_name = "my-table"
        lc = ResourceLifecycleConfig()
        dynamodb_tracker = ResourceStateTracker(lc)
        dynamodb_tracker.set_state(expected_table_name, "CREATING")
        table_config = TableConfig(
            table_name=expected_table_name,
            key_schema=KeySchema(partition_key=KeyAttribute(name="id", type="S")),
        )
        dynamodb_provider = SqliteDynamoProvider(
            data_dir=tmp_path / "dynamodb", tables=[table_config]
        )
        provider = await _started_provider()
        app = create_eventbridge_app(
            provider,
            dynamodb_provider=dynamodb_provider,
            dynamodb_tracker=dynamodb_tracker,
        )

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                content=json.dumps(_put_targets_body(expected_table_name)),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        assert expected_error_fragment in actual_body.get(
            "Error", ""
        ), f"Expected {expected_error_fragment!r} to be in {actual_body!r}"

    @pytest.mark.asyncio
    async def test_put_targets_rejected_when_dynamodb_table_is_deleting(self, tmp_path) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        expected_table_name = "my-table"
        lc = ResourceLifecycleConfig()
        dynamodb_tracker = ResourceStateTracker(lc)
        dynamodb_tracker.set_state(expected_table_name, "DELETING")
        table_config = TableConfig(
            table_name=expected_table_name,
            key_schema=KeySchema(partition_key=KeyAttribute(name="id", type="S")),
        )
        dynamodb_provider = SqliteDynamoProvider(
            data_dir=tmp_path / "dynamodb", tables=[table_config]
        )
        provider = await _started_provider()
        app = create_eventbridge_app(
            provider,
            dynamodb_provider=dynamodb_provider,
            dynamodb_tracker=dynamodb_tracker,
        )

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                content=json.dumps(_put_targets_body(expected_table_name)),
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        actual_body = response.json()
        assert expected_error_fragment in actual_body.get(
            "Error", ""
        ), f"Expected {expected_error_fragment!r} to be in {actual_body!r}"
