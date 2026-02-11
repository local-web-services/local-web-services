"""Integration test for DynamoDB Query."""

from __future__ import annotations

import httpx


class TestQuery:
    async def test_query(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pk = {"S": "user1"}
        expected_data = {"S": "some-data"}
        table_name = "TestTable"

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
            headers={"X-Amz-Target": "DynamoDB_20120810.Query"},
            json={
                "TableName": table_name,
                "KeyConditionExpression": "pk = :pk_val",
                "ExpressionAttributeValues": {":pk_val": expected_pk},
            },
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "Items" in body
        assert len(body["Items"]) >= 1
        actual_item = body["Items"][0]
        assert actual_item["pk"] == expected_pk
        assert actual_item["data"] == expected_data
