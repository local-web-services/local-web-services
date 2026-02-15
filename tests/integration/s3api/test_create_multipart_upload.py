"""Integration test for S3 CreateMultipartUpload."""

from __future__ import annotations

import httpx


class TestCreateMultipartUpload:
    async def test_create_multipart_upload(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bucket = "test-bucket"
        expected_key = "test-key"

        # Act
        resp = await client.post(
            f"/{expected_bucket}/{expected_key}",
            params={"uploads": ""},
        )

        # Assert
        assert resp.status_code == expected_status_code
