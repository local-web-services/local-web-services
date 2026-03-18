"""Integration test for S3 DeleteBucket."""

from __future__ import annotations

import httpx


class TestDeleteBucket:
    async def test_delete_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket_name = "bucket-to-delete"
        expected_create_status = 200
        expected_delete_status = 204

        create_resp = await client.put(f"/{expected_bucket_name}")
        assert create_resp.status_code == expected_create_status

        # Act
        resp = await client.delete(f"/{expected_bucket_name}")

        # Assert
        assert resp.status_code == expected_delete_status
