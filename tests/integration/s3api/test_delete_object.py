"""Integration test for S3 DeleteObject."""

from __future__ import annotations

import httpx


class TestDeleteObject:
    async def test_delete_object(self, client: httpx.AsyncClient):
        # Arrange
        expected_path = "/test-bucket/del-key"
        expected_delete_status = 204
        expected_not_found_status = 404

        await client.put(expected_path, content=b"bye")

        # Act
        del_resp = await client.delete(expected_path)

        # Assert
        assert del_resp.status_code == expected_delete_status

        # Act
        get_resp = await client.get(expected_path)

        # Assert
        assert get_resp.status_code == expected_not_found_status
