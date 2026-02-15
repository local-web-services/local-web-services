"""Integration test for Lambda ListFunctions."""

from __future__ import annotations

import httpx


class TestListFunctions:
    async def test_list_functions(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.get("/2015-03-31/functions")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
