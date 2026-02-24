"""Integration tests for DynamoDB GetItem."""

from __future__ import annotations

import httpx


class TestGetItem:
    async def test_get_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pk = {"S": "item1"}
        expected_data = {"S": "hello"}
        table_name = "TestTable"
        pk_value = "item1"

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": expected_pk, "data": expected_data},
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": table_name, "Key": {"pk": {"S": pk_value}}},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_pk = body["Item"]["pk"]
        actual_data = body["Item"]["data"]
        assert actual_pk == expected_pk
        assert actual_data == expected_data

    async def test_get_item_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": table_name, "Key": {"pk": {"S": "nonexistent"}}},
        )

        # Assert
        assert response.status_code == expected_status_code
        assert "Item" not in response.json()
