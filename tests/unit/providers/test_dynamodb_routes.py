"""Tests for ldk.providers.dynamodb.routes -- DynamoDB wire protocol server."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces.key_value_store import IKeyValueStore
from lws.providers.dynamodb.routes import create_dynamodb_app

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture()
def mock_store() -> AsyncMock:
    """Return an ``AsyncMock`` that satisfies ``IKeyValueStore``."""
    store = AsyncMock(spec=IKeyValueStore)
    # Sensible defaults so tests that don't care about return values still pass.
    store.get_item.return_value = None
    store.put_item.return_value = None
    store.delete_item.return_value = None
    store.update_item.return_value = {}
    store.query.return_value = []
    store.scan.return_value = []
    store.batch_get_items.return_value = []
    store.batch_write_items.return_value = None
    return store


@pytest.fixture()
def client(mock_store: AsyncMock) -> httpx.AsyncClient:
    """Create an ``httpx.AsyncClient`` wired to the DynamoDB ASGI app."""
    app = create_dynamodb_app(mock_store)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{TARGET_PREFIX}{operation}"}


# ---------------------------------------------------------------------------
# PutItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_put_item(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    payload = {
        "TableName": "Users",
        "Item": {"pk": {"S": "user#1"}, "name": {"S": "Alice"}},
    }
    expected_status_code = 200

    # Act
    resp = await client.post("/", json=payload, headers=_target("PutItem"))

    # Assert
    assert resp.status_code == expected_status_code
    mock_store.put_item.assert_awaited_once_with(
        "Users",
        {"pk": {"S": "user#1"}, "name": {"S": "Alice"}},
    )


# ---------------------------------------------------------------------------
# GetItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_get_item_found(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.get_item.return_value = {
        "pk": {"S": "user#1"},
        "name": {"S": "Alice"},
    }
    payload = {"TableName": "Users", "Key": {"pk": {"S": "user#1"}}}
    expected_status_code = 200
    expected_pk = {"S": "user#1"}

    # Act
    resp = await client.post("/", json=payload, headers=_target("GetItem"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    assert "Item" in data
    actual_pk = data["Item"]["pk"]
    assert actual_pk == expected_pk
    mock_store.get_item.assert_awaited_once_with("Users", {"pk": {"S": "user#1"}})


@pytest.mark.asyncio
async def test_get_item_not_found(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.get_item.return_value = None
    payload = {"TableName": "Users", "Key": {"pk": {"S": "user#999"}}}
    expected_status_code = 200

    # Act
    resp = await client.post("/", json=payload, headers=_target("GetItem"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    assert "Item" not in data


# ---------------------------------------------------------------------------
# DeleteItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_delete_item(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    payload = {"TableName": "Users", "Key": {"pk": {"S": "user#1"}}}
    expected_status_code = 200

    # Act
    resp = await client.post("/", json=payload, headers=_target("DeleteItem"))

    # Assert
    assert resp.status_code == expected_status_code
    mock_store.delete_item.assert_awaited_once_with("Users", {"pk": {"S": "user#1"}})


# ---------------------------------------------------------------------------
# UpdateItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_update_item(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.update_item.return_value = {
        "pk": {"S": "user#1"},
        "name": {"S": "Bob"},
    }
    payload = {
        "TableName": "Users",
        "Key": {"pk": {"S": "user#1"}},
        "UpdateExpression": "SET #n = :val",
        "ExpressionAttributeNames": {"#n": "name"},
        "ExpressionAttributeValues": {":val": {"S": "Bob"}},
    }
    expected_status_code = 200
    expected_name = {"S": "Bob"}

    # Act
    resp = await client.post("/", json=payload, headers=_target("UpdateItem"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    actual_name = data["Attributes"]["name"]
    assert actual_name == expected_name
    mock_store.update_item.assert_awaited_once_with(
        "Users",
        {"pk": {"S": "user#1"}},
        "SET #n = :val",
        expression_values={":val": {"S": "Bob"}},
        expression_names={"#n": "name"},
    )


# ---------------------------------------------------------------------------
# Query
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_query(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.query.return_value = [
        {"pk": {"S": "user#1"}, "sk": {"S": "order#1"}},
    ]
    payload = {
        "TableName": "Orders",
        "KeyConditionExpression": "pk = :pk",
        "ExpressionAttributeValues": {":pk": {"S": "user#1"}},
    }
    expected_status_code = 200
    expected_count = 1

    # Act
    resp = await client.post("/", json=payload, headers=_target("Query"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    actual_count = data["Count"]
    assert actual_count == expected_count
    assert len(data["Items"]) == expected_count


# ---------------------------------------------------------------------------
# Scan
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_scan(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.scan.return_value = [
        {"pk": {"S": "a"}},
        {"pk": {"S": "b"}},
    ]
    payload = {"TableName": "Users"}
    expected_status_code = 200
    expected_count = 2

    # Act
    resp = await client.post("/", json=payload, headers=_target("Scan"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    actual_count = data["Count"]
    assert actual_count == expected_count
    assert len(data["Items"]) == expected_count


# ---------------------------------------------------------------------------
# BatchGetItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_batch_get_item(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    mock_store.batch_get_items.return_value = [
        {"pk": {"S": "user#1"}},
        {"pk": {"S": "user#2"}},
    ]
    payload = {
        "RequestItems": {
            "Users": {
                "Keys": [
                    {"pk": {"S": "user#1"}},
                    {"pk": {"S": "user#2"}},
                ]
            }
        }
    }
    expected_status_code = 200
    expected_response_count = 2

    # Act
    resp = await client.post("/", json=payload, headers=_target("BatchGetItem"))

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    assert "Responses" in data
    assert len(data["Responses"]["Users"]) == expected_response_count


# ---------------------------------------------------------------------------
# BatchWriteItem
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_batch_write_item(client: httpx.AsyncClient, mock_store: AsyncMock) -> None:
    # Arrange
    payload = {
        "RequestItems": {
            "Users": [
                {"PutRequest": {"Item": {"pk": {"S": "user#1"}, "name": {"S": "A"}}}},
                {"DeleteRequest": {"Key": {"pk": {"S": "user#2"}}}},
            ]
        }
    }
    expected_status_code = 200

    # Act
    resp = await client.post("/", json=payload, headers=_target("BatchWriteItem"))

    # Assert
    assert resp.status_code == expected_status_code
    mock_store.batch_write_items.assert_awaited_once_with(
        "Users",
        put_items=[{"pk": {"S": "user#1"}, "name": {"S": "A"}}],
        delete_keys=[{"pk": {"S": "user#2"}}],
    )


# ---------------------------------------------------------------------------
# Unknown operation
# ---------------------------------------------------------------------------


@pytest.mark.asyncio
async def test_unknown_operation_returns_error(
    client: httpx.AsyncClient,
) -> None:
    # Arrange
    payload = {"TableName": "Users"}
    expected_status_code = 400
    expected_error_type = "UnknownOperationException"

    # Act
    resp = await client.post("/", json=payload, headers=_target("SomeUnknownOp"))

    # Assert
    assert resp.status_code == expected_status_code
    body = resp.json()
    actual_error_type = body["__type"]
    assert actual_error_type == expected_error_type
    assert "lws" in body["message"]
    assert "DynamoDB" in body["message"]
    assert "SomeUnknownOp" in body["message"]


@pytest.mark.asyncio
async def test_missing_target_header_returns_400(
    client: httpx.AsyncClient,
) -> None:
    # Arrange
    expected_status_code = 400
    expected_error_type = "ValidationException"

    # Act
    resp = await client.post("/", json={"TableName": "Users"})

    # Assert
    assert resp.status_code == expected_status_code
    data = resp.json()
    actual_error_type = data["__type"]
    assert actual_error_type == expected_error_type
