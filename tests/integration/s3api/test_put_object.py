"""Integration test for S3 PutObject and GetObject."""

from __future__ import annotations

import httpx


class TestPutObject:
    async def test_put_and_get_object(self, client: httpx.AsyncClient):
        # Arrange
        expected_path = "/test-bucket/my-key"
        expected_content = b"hello s3"
        expected_status_code = 200

        # Act
        put_resp = await client.put(expected_path, content=expected_content)

        # Assert
        assert put_resp.status_code == expected_status_code

        # Act
        get_resp = await client.get(expected_path)

        # Assert
        assert get_resp.status_code == expected_status_code
        actual_content = get_resp.content
        assert actual_content == expected_content
