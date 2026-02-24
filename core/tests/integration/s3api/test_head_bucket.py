"""Integration test for S3 HeadBucket."""

from __future__ import annotations

import httpx


class TestHeadBucket:
    async def test_head_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket_name = "test-bucket"
        expected_status_code = 200

        # Act
        resp = await client.head(f"/{expected_bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code
        actual_region = resp.headers["x-amz-bucket-region"]
        assert actual_region == "us-east-1"

    async def test_head_bucket_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket_name = "nonexistent-bucket"
        expected_status_code = 404

        # Act
        resp = await client.head(f"/{expected_bucket_name}")

        # Assert
        assert resp.status_code == expected_status_code
