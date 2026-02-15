"""Integration test for Lambda DeleteFunction."""

from __future__ import annotations

import httpx


class TestDeleteFunction:
    async def test_delete_nonexistent_function(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204

        # Act
        resp = await client.delete("/2015-03-31/functions/nonexistent")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
