"""Integration tests for DynamoDB GSI (Global Secondary Index) operations."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app

_TARGET_PREFIX = "DynamoDB_20120810."

_GSI_TABLE = "gsi-round-trip-table"
_TABLE_PK = "orderId"
_GSI_INDEX = "byStatus"
_GSI_PK = "status"


def _target(op: str) -> dict:
    return {"X-Amz-Target": f"{_TARGET_PREFIX}{op}"}


@pytest.fixture
async def gsi_provider(tmp_path: Path):
    p = SqliteDynamoProvider(data_dir=tmp_path, tables=[])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def gsi_app(gsi_provider):
    return create_dynamodb_app(gsi_provider)


@pytest.fixture
async def gsi_client(gsi_app):
    transport = httpx.ASGITransport(app=gsi_app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


async def _create_gsi_table(client: httpx.AsyncClient) -> None:
    """Helper: create a table with a GSI via the wire protocol."""
    resp = await client.post(
        "/",
        json={
            "TableName": _GSI_TABLE,
            "KeySchema": [{"AttributeName": _TABLE_PK, "KeyType": "HASH"}],
            "AttributeDefinitions": [
                {"AttributeName": _TABLE_PK, "AttributeType": "S"},
                {"AttributeName": _GSI_PK, "AttributeType": "S"},
            ],
            "GlobalSecondaryIndexes": [
                {
                    "IndexName": _GSI_INDEX,
                    "KeySchema": [{"AttributeName": _GSI_PK, "KeyType": "HASH"}],
                    "Projection": {"ProjectionType": "ALL"},
                }
            ],
            "BillingMode": "PAY_PER_REQUEST",
        },
        headers=_target("CreateTable"),
    )
    expected_status = 200
    assert (
        resp.status_code == expected_status
    ), f"Expected {expected_status!r} but got {resp.status_code!r}: {resp.text}"


async def _put(client: httpx.AsyncClient, pk: str, status: str) -> None:
    """Helper: put an item into the GSI table."""
    await client.post(
        "/",
        json={
            "TableName": _GSI_TABLE,
            "Item": {_TABLE_PK: {"S": pk}, _GSI_PK: {"S": status}},
        },
        headers=_target("PutItem"),
    )


class TestDynamoDbGsi:
    async def test_query_via_gsi_returns_matching_items(self, gsi_client: httpx.AsyncClient):
        # Arrange
        await _create_gsi_table(gsi_client)
        await _put(gsi_client, "order-1", "shipped")
        await _put(gsi_client, "order-2", "shipped")
        await _put(gsi_client, "order-3", "pending")
        expected_count = 2
        expected_status_set = {"shipped"}

        # Act
        resp = await gsi_client.post(
            "/",
            json={
                "TableName": _GSI_TABLE,
                "IndexName": _GSI_INDEX,
                "KeyConditionExpression": "#s = :s",
                "ExpressionAttributeNames": {"#s": _GSI_PK},
                "ExpressionAttributeValues": {":s": {"S": "shipped"}},
            },
            headers=_target("Query"),
        )

        # Assert
        expected_response_status = 200
        assert (
            resp.status_code == expected_response_status
        ), f"Expected {expected_response_status!r} but got {resp.status_code!r}"
        actual_count = resp.json()["Count"]
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"
        actual_status_set = {item[_GSI_PK]["S"] for item in resp.json()["Items"]}
        assert (
            actual_status_set == expected_status_set
        ), f"Expected {expected_status_set!r} but got {actual_status_set!r}"

    async def test_sparse_index_excludes_items_without_gsi_key(self, gsi_client: httpx.AsyncClient):
        # Arrange
        await _create_gsi_table(gsi_client)
        await _put(gsi_client, "order-a", "shipped")
        # Put an item that has no GSI key attribute (sparse index)
        await gsi_client.post(
            "/",
            json={
                "TableName": _GSI_TABLE,
                "Item": {_TABLE_PK: {"S": "order-b"}},
            },
            headers=_target("PutItem"),
        )
        expected_count = 1

        # Act
        resp = await gsi_client.post(
            "/",
            json={
                "TableName": _GSI_TABLE,
                "IndexName": _GSI_INDEX,
                "KeyConditionExpression": "#s = :s",
                "ExpressionAttributeNames": {"#s": _GSI_PK},
                "ExpressionAttributeValues": {":s": {"S": "shipped"}},
            },
            headers=_target("Query"),
        )

        # Assert
        expected_response_status = 200
        assert (
            resp.status_code == expected_response_status
        ), f"Expected {expected_response_status!r} but got {resp.status_code!r}"
        actual_count = resp.json()["Count"]
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} (sparse item excluded) but got {actual_count!r}"

    async def test_delete_item_removes_gsi_entry(self, gsi_client: httpx.AsyncClient):
        # Arrange
        await _create_gsi_table(gsi_client)
        await _put(gsi_client, "order-x", "shipped")
        await gsi_client.post(
            "/",
            json={"TableName": _GSI_TABLE, "Key": {_TABLE_PK: {"S": "order-x"}}},
            headers=_target("DeleteItem"),
        )
        expected_count = 0

        # Act
        resp = await gsi_client.post(
            "/",
            json={
                "TableName": _GSI_TABLE,
                "IndexName": _GSI_INDEX,
                "KeyConditionExpression": "#s = :s",
                "ExpressionAttributeNames": {"#s": _GSI_PK},
                "ExpressionAttributeValues": {":s": {"S": "shipped"}},
            },
            headers=_target("Query"),
        )

        # Assert
        expected_response_status = 200
        assert (
            resp.status_code == expected_response_status
        ), f"Expected {expected_response_status!r} but got {resp.status_code!r}"
        actual_count = resp.json()["Count"]
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} after deletion but got {actual_count!r}"
