"""Integration test for DynamoDB DeleteItem."""

from __future__ import annotations

import httpx


class TestDeleteItem:
    async def test_delete_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"
        pk_value = "item1"
        key = {"pk": {"S": pk_value}}

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": pk_value}, "data": {"S": "hello"}},
            },
        )

        # Act
        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.DeleteItem"},
            json={"TableName": table_name, "Key": key},
        )

        # Assert
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
            json={"TableName": table_name, "Key": key},
        )
        assert response.status_code == expected_status_code
        assert "Item" not in response.json()
