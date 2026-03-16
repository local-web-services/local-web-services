"""Integration test for DynamoDB UpdateItem."""

from __future__ import annotations

import httpx


class TestUpdateItem:
    async def test_update_item(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        table_name = "TestTable"

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={
                "TableName": table_name,
                "Item": {"pk": {"S": "upd1"}, "data": {"S": "original"}},
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.UpdateItem"},
            json={
                "TableName": table_name,
                "Key": {"pk": {"S": "upd1"}},
                "UpdateExpression": "SET #d = :val",
                "ExpressionAttributeValues": {":val": {"S": "updated"}},
                "ExpressionAttributeNames": {"#d": "data"},
            },
        )

        # Assert
        assert response.status_code == expected_status_code
