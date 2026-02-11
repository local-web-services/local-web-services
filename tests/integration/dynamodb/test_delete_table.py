"""Integration test for DynamoDB DeleteTable."""

from __future__ import annotations

import httpx


class TestDeleteTable:
    async def test_delete_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_table_name = "TableToDelete"

        await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.CreateTable"},
            json={
                "TableName": expected_table_name,
                "AttributeDefinitions": [
                    {"AttributeName": "id", "AttributeType": "S"},
                ],
                "KeySchema": [
                    {"AttributeName": "id", "KeyType": "HASH"},
                ],
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.DeleteTable"},
            json={"TableName": expected_table_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "TableDescription" in body
        assert body["TableDescription"]["TableName"] == expected_table_name
