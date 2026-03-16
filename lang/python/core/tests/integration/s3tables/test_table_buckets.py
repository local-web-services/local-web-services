"""Integration tests for S3 Tables table bucket operations."""

from __future__ import annotations

import httpx


class TestCreateTableBucket:
    async def test_create_table_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "integration-bucket"

        # Act
        resp = await client.put(
            "/table-buckets",
            json={"name": bucket_name},
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        assert "tableBucketARN" in actual_body
        assert bucket_name in actual_body["tableBucketARN"]

    async def test_create_duplicate_table_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 409
        bucket_name = "dup-integration-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.put(
            "/table-buckets",
            json={"name": bucket_name},
        )

        # Assert
        assert resp.status_code == expected_status_code


class TestListTableBuckets:
    async def test_list_table_buckets(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "listed-integration-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.get("/table-buckets")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name in actual_names


class TestGetTableBucket:
    async def test_get_table_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "get-integration-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_name = actual_body["name"]
        assert actual_name == bucket_name

    async def test_get_table_bucket_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        bucket_name = "nonexistent-integration-bucket"

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code


class TestDeleteTableBucket:
    async def test_delete_table_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        bucket_name = "del-integration-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.delete(f"/table-buckets/{bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code

    async def test_delete_then_list_confirms_removal(self, client: httpx.AsyncClient):
        # Arrange
        bucket_name = "del-verify-integration-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.delete(f"/table-buckets/{bucket_name}")

        # Act
        resp = await client.get("/table-buckets")

        # Assert
        actual_body = resp.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name not in actual_names
