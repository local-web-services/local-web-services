"""Integration test for Lambda CreateFunction."""

from __future__ import annotations

import httpx


class TestCreateFunction:
    async def test_create_function_returns_response(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        expected_function_name = "test-function"

        # Act
        resp = await client.post(
            "/2015-03-31/functions",
            json={
                "FunctionName": expected_function_name,
                "Runtime": "python3.12",
                "Role": "arn:aws:iam::123456789012:role/test-role",
                "Handler": "index.handler",
                "Code": {"ZipFile": ""},
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        actual_body = resp.json()
        assert actual_body["FunctionName"] == expected_function_name
