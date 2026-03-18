"""Integration test for S3 ListBuckets."""

from __future__ import annotations

import httpx


class TestListBuckets:
    async def test_list_buckets(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bucket_name = "test-bucket"

        # Act
        resp = await client.get("/")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.text
        assert expected_bucket_name in actual_body
        assert "ListAllMyBucketsResult" in actual_body
