"""Integration test for DynamoDB BatchWriteItem."""

from __future__ import annotations

import httpx


class TestBatchWriteItem:
    async def test_batch_write_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.BatchWriteItem"},
            json={
                "RequestItems": {
                    table_name: [
                        {"PutRequest": {"Item": {"pk": {"S": "bw1"}, "data": {"S": "val1"}}}},
                        {"PutRequest": {"Item": {"pk": {"S": "bw2"}, "data": {"S": "val2"}}}},
                    ]
                }
            },
        )

        # Assert
        assert response.status_code == expected_status_code
