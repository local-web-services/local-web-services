"""Integration test for S3 ListObjectsV2."""

from __future__ import annotations

import httpx


class TestListObjectsV2:
    async def test_list_objects(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_key_a = "<Key>list/a.txt</Key>"
        expected_key_b = "<Key>list/b.txt</Key>"

        await client.put("/test-bucket/list/a.txt", content=b"aaa")
        await client.put("/test-bucket/list/b.txt", content=b"bbb")

        # Act
        list_resp = await client.get("/test-bucket", params={"list-type": "2"})

        # Assert
        assert list_resp.status_code == expected_status_code
        actual_text = list_resp.text
        assert expected_key_a in actual_text
        assert expected_key_b in actual_text
