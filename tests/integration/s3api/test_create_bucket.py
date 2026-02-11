"""Integration test for S3 CreateBucket."""

from __future__ import annotations

import httpx


class TestCreateBucket:
    async def test_create_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket_name = "new-bucket"
        expected_status_code = 200

        # Act
        resp = await client.put(f"/{expected_bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code
