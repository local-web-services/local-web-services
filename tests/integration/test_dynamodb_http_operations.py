"""Integration tests for the DynamoDB HTTP wire protocol."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


@pytest.fixture
async def provider(tmp_path: Path):
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
def app(provider):
    return create_dynamodb_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestDynamoDbHttpOperations:
    async def test_put_item(self, client: httpx.AsyncClient):
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": "TestTable",
                "Item": {"pk": {"S": "item1"}, "data": {"S": "hello"}},
            },
        )
        assert response.status_code == 200

    async def test_get_item(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": "TestTable",
                "Item": {"pk": {"S": "item1"}, "data": {"S": "hello"}},
            },
        )

        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "item1"}}},
        )
        assert response.status_code == 200
        body = response.json()
        assert body["Item"]["pk"] == {"S": "item1"}
        assert body["Item"]["data"] == {"S": "hello"}

    async def test_delete_item(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": "TestTable",
                "Item": {"pk": {"S": "item1"}, "data": {"S": "hello"}},
            },
        )

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.DeleteItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "item1"}}},
        )

        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "item1"}}},
        )
        assert response.status_code == 200
        assert "Item" not in response.json()

    async def test_get_item_not_found(self, client: httpx.AsyncClient):
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": "TestTable", "Key": {"pk": {"S": "nonexistent"}}},
        )
        assert response.status_code == 200
        assert "Item" not in response.json()
