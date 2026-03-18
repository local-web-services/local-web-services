"""Integration test for DynamoDB BatchGetItem."""

from __future__ import annotations

import httpx


class TestBatchGetItem:
    async def test_batch_get_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": "bg1"}, "data": {"S": "hello"}},
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.BatchGetItem"},
            json={"RequestItems": {table_name: {"Keys": [{"pk": {"S": "bg1"}}]}}},
        )

        # Assert
        assert response.status_code == expected_status_code
