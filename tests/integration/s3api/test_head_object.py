"""Integration test for S3 HeadObject."""

from __future__ import annotations

import httpx


class TestHeadObject:
    async def test_head_object(self, client: httpx.AsyncClient):
        # Arrange
        expected_path = "/test-bucket/head-key"
        expected_status_code = 200
        expected_content_length = "5"

        await client.put(expected_path, content=b"12345")

        # Act
        head_resp = await client.head(expected_path)

        # Assert
        assert head_resp.status_code == expected_status_code
        actual_content_length = head_resp.headers["content-length"]
        assert actual_content_length == expected_content_length
