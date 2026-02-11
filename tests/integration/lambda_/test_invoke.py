"""Integration test for Lambda invoke via Lambda management API."""

from __future__ import annotations

import httpx


class TestInvoke:
    async def test_invoke_unknown_function_returns_404(self, client: httpx.AsyncClient):
        # Arrange
        expected_function_name = "nonexistent-function"
        expected_status_code = 404

        # Act
        resp = await client.post(
            f"/2015-03-31/functions/{expected_function_name}/invocations",
            json={},
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        assert "Message" in actual_body
        assert expected_function_name in actual_body["Message"]
