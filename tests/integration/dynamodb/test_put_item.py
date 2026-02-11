"""Integration test for DynamoDB PutItem."""

from __future__ import annotations

import httpx


class TestPutItem:
    async def test_put_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": "item1"}, "data": {"S": "hello"}},
            },
        )

        # Assert
        assert response.status_code == expected_status_code
