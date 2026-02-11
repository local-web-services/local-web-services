"""Integration test for DynamoDB DescribeTable."""

from __future__ import annotations

import httpx


class TestDescribeTable:
    async def test_describe_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_table_name = "TestTable"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.DescribeTable"},
            json={"TableName": expected_table_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "Table" in body
        assert body["Table"]["TableName"] == expected_table_name
