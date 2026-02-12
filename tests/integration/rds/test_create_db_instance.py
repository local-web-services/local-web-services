"""Integration test for RDS CreateDBInstance."""

from __future__ import annotations

import httpx


class TestCreateDBInstance:
    async def test_create_db_instance(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        db_id = "int-rds-instance"
        expected_db_id = db_id

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id, "Engine": "postgres"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_db_id = body["DBInstance"]["DBInstanceIdentifier"]
        assert actual_db_id == expected_db_id
        assert "Endpoint" in body["DBInstance"]
        assert "DBInstanceArn" in body["DBInstance"]

    async def test_create_duplicate_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "DBInstanceAlreadyExistsFault"
        db_id = "int-rds-dup-instance"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_create_then_describe(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        db_id = "int-rds-create-desc"
        expected_db_id = db_id

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBInstance"},
            json={"DBInstanceIdentifier": db_id, "Engine": "postgres"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBInstances"},
            json={"DBInstanceIdentifier": db_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_count = 1
        assert len(body["DBInstances"]) == expected_count
        actual_db_id = body["DBInstances"][0]["DBInstanceIdentifier"]
        assert actual_db_id == expected_db_id
