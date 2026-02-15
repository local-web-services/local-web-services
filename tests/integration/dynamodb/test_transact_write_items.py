"""Integration test for DynamoDB TransactWriteItems."""

from __future__ import annotations

import httpx


class TestTransactWriteItems:
    async def test_transact_write_items_puts_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"
        expected_pk = {"S": "txn-item-1"}
        expected_data = {"S": "transact-data"}

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.TransactWriteItems"},
            json={
                "TransactItems": [
                    {
                        "Put": {
                            "TableName": table_name,
                            "Item": {
                                "pk": expected_pk,
                                "data": expected_data,
                            },
                        }
                    }
                ]
            },
        )

        # Assert
        assert response.status_code == expected_status_code
