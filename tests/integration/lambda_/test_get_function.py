"""Integration test for Lambda GetFunction."""

from __future__ import annotations

import httpx


class TestGetFunction:
    async def test_get_nonexistent_function(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404

        # Act
        resp = await client.get("/2015-03-31/functions/nonexistent")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
