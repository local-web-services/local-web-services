"""Tests that DynamoDB routes reject requests when capacity is exhausted."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces.key_value_store import IKeyValueStore
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.dynamodb.routes import create_dynamodb_app

_TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{_TARGET_PREFIX}{operation}"}


class TestDynamoDbRoutesCapacityExhausted:
    """DynamoDB routes return capacity error when slots=0."""

    @pytest.fixture()
    def client(self) -> httpx.AsyncClient:
        # Arrange
        store = AsyncMock(spec=IKeyValueStore)
        capacity = AwsCapacityConfig(slots=0)
        app = create_dynamodb_app(store, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_get_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("GetItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_put_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("PutItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_delete_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("DeleteItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_update_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("UpdateItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_query_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("Query"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_scan_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("Scan"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_batch_get_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("BatchGetItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_batch_write_item_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("BatchWriteItem"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_transact_write_items_capacity_exhausted(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "ProvisionedThroughputExceededException"

        # Act
        resp = await client.post("/", json={}, headers=_target("TransactWriteItems"))

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
