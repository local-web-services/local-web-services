"""Integration test for DynamoDB Scan."""

from __future__ import annotations

import httpx


class TestScan:
    async def test_scan(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pk = {"S": "scan-item1"}
        expected_data = {"S": "scan-data"}
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
            headers={"X-Amz-Target": "DynamoDB_20120810.Scan"},
            json={"TableName": table_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "Items" in body
        assert len(body["Items"]) >= 1
        actual_pks = [item["pk"] for item in body["Items"]]
        assert expected_pk in actual_pks
