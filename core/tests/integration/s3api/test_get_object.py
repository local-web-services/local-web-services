"""Integration test for S3 GetObject."""

from __future__ import annotations

import httpx


class TestGetObject:
    async def test_get_object(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket = "test-bucket"
        expected_key = "get-test-key"
        expected_content = b"get object content"
        expected_status_code = 200

        await client.put(f"/{expected_bucket}/{expected_key}", content=expected_content)

        # Act
        resp = await client.get(f"/{expected_bucket}/{expected_key}")

        # Assert
        assert resp.status_code == expected_status_code
        actual_content = resp.content
        assert actual_content == expected_content

    async def test_get_object_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_bucket = "test-bucket"
        expected_key = "nonexistent-key"
        expected_status_code = 404

        # Act
        resp = await client.get(f"/{expected_bucket}/{expected_key}")

        # Assert
        assert resp.status_code == expected_status_code
