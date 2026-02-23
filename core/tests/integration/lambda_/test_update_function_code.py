"""Integration test for Lambda UpdateFunctionCode."""

from __future__ import annotations

import httpx


class TestUpdateFunctionCode:
    async def test_update_nonexistent_function_code(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404

        # Act
        resp = await client.put(
            "/2015-03-31/functions/nonexistent/code",
            json={"ZipFile": ""},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
