"""Integration test for DynamoDB ListTables."""

from __future__ import annotations

import httpx


class TestListTables:
    async def test_list_tables(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_table_name = "TestTable"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.ListTables"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "TableNames" in body
        assert expected_table_name in body["TableNames"]
