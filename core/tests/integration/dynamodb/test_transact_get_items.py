"""Integration test for DynamoDB TransactGetItems."""

from __future__ import annotations

import httpx


class TestTransactGetItems:
    async def test_transact_get_items(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": "tg1"}, "data": {"S": "value"}},
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.TransactGetItems"},
            json={
                "TransactItems": [
                    {
                        "Get": {
                            "TableName": table_name,
                            "Key": {"pk": {"S": "tg1"}},
                        }
                    }
                ]
            },
        )

        # Assert
        assert response.status_code == expected_status_code
