"""Tests for DynamoDB TransactWriteItems ConditionCheck evaluation."""

from __future__ import annotations

import httpx
import pytest

from lws.interfaces.key_value_store import KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app

TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{TARGET_PREFIX}{operation}"}


_TABLE_CONFIG = TableConfig(
    table_name="TestTable",
    key_schema=KeySchema(
        partition_key=KeyAttribute(name="pk", type="S"),
    ),
)


@pytest.fixture()
async def provider(tmp_path):
    p = SqliteDynamoProvider(data_dir=tmp_path, tables=[_TABLE_CONFIG])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture()
def client(provider: SqliteDynamoProvider) -> httpx.AsyncClient:
    app = create_dynamodb_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestTransactConditionCheck:
    @pytest.mark.asyncio
    async def test_condition_check_passes_writes_execute(
        self, client: httpx.AsyncClient, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        table_name = "TestTable"
        await provider.put_item(table_name, {"pk": {"S": "existing"}, "status": {"S": "active"}})
        payload = {
            "TransactItems": [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "existing"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {"pk": {"S": "new-item"}, "data": {"S": "hello"}},
                    }
                },
            ]
        }
        expected_status_code = 200
        expected_data = {"S": "hello"}

        # Act
        resp = await client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        item = await provider.get_item(table_name, {"pk": {"S": "new-item"}})
        actual_data = item["data"]
        assert actual_data == expected_data

    @pytest.mark.asyncio
    async def test_condition_check_fails_no_writes_execute(
        self, client: httpx.AsyncClient, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        table_name = "TestTable"
        payload = {
            "TransactItems": [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "nonexistent"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {"pk": {"S": "should-not-exist"}, "data": {"S": "nope"}},
                    }
                },
            ]
        }
        expected_status_code = 400
        expected_error_type = "com.amazonaws.dynamodb.v20120810#TransactionCanceledException"

        # Act
        resp = await client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert len(body["CancellationReasons"]) == 2
        actual_reason_code = body["CancellationReasons"][0]["Code"]
        expected_reason_code = "ConditionalCheckFailed"
        assert actual_reason_code == expected_reason_code
        item = await provider.get_item(table_name, {"pk": {"S": "should-not-exist"}})
        assert item is None

    @pytest.mark.asyncio
    async def test_put_with_condition_expression_fails_transaction_cancelled(
        self, client: httpx.AsyncClient, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        table_name = "TestTable"
        payload = {
            "TransactItems": [
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {"pk": {"S": "item1"}, "data": {"S": "val"}},
                        "ConditionExpression": "attribute_exists(pk)",
                        "Key": {"pk": {"S": "item1"}},
                    }
                },
            ]
        }
        expected_status_code = 400

        # Act
        resp = await client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_reason_code = body["CancellationReasons"][0]["Code"]
        expected_reason_code = "ConditionalCheckFailed"
        assert actual_reason_code == expected_reason_code

    @pytest.mark.asyncio
    async def test_multiple_condition_checks_one_fails_all_cancelled(
        self, client: httpx.AsyncClient, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        table_name = "TestTable"
        await provider.put_item(table_name, {"pk": {"S": "exists1"}, "val": {"S": "a"}})
        payload = {
            "TransactItems": [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "exists1"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "does-not-exist"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {"pk": {"S": "new"}, "data": {"S": "v"}},
                    }
                },
            ]
        }
        expected_status_code = 400

        # Act
        resp = await client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        reasons = body["CancellationReasons"]
        assert len(reasons) == 3
        actual_first = reasons[0]["Code"]
        expected_first = "None"
        assert actual_first == expected_first
        actual_second = reasons[1]["Code"]
        expected_second = "ConditionalCheckFailed"
        assert actual_second == expected_second
        item = await provider.get_item(table_name, {"pk": {"S": "new"}})
        assert item is None

    @pytest.mark.asyncio
    async def test_condition_check_with_expression_attribute_names_and_values(
        self, client: httpx.AsyncClient, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        table_name = "TestTable"
        await provider.put_item(table_name, {"pk": {"S": "item1"}, "status": {"S": "active"}})
        payload = {
            "TransactItems": [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "item1"}},
                        "ConditionExpression": "#s = :v",
                        "ExpressionAttributeNames": {"#s": "status"},
                        "ExpressionAttributeValues": {":v": {"S": "active"}},
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {"pk": {"S": "item2"}, "data": {"S": "ok"}},
                    }
                },
            ]
        }
        expected_status_code = 200

        # Act
        resp = await client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        item = await provider.get_item(table_name, {"pk": {"S": "item2"}})
        assert item is not None
