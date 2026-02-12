"""Integration test for RDS DescribeDBInstances."""

from __future__ import annotations

import httpx


class TestDescribeDBInstances:
    async def test_describe_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBInstances"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DBInstances"]) == expected_count

    async def test_describe_after_create(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        db_id_a = "int-rds-desc-a"
        db_id_b = "int-rds-desc-b"
        expected_count = 2

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id_a},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id_b},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBInstances"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DBInstances"]) == expected_count
        ids = [i["DBInstanceIdentifier"] for i in body["DBInstances"]]
        assert db_id_a in ids
        assert db_id_b in ids

    async def test_describe_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        expected_error_type = "DBInstanceNotFoundFault"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBInstances"},
            json={"DBInstanceIdentifier": "no-such-instance"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
