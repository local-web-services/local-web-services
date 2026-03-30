"""Tests for Lambda management GET /lws/lambda/invocations/{function_name} endpoint."""

from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app


@pytest.fixture
def app():
    """Create a Lambda management app."""
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    """Create an async HTTP client for the app."""
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


class TestLambdaFunctionInvocationsEndpoint:
    """Tests for the per-function invocation history endpoint."""

    async def test_unknown_function_returns_empty_invocations(self, client: AsyncClient) -> None:
        # Arrange
        expected_invocations: list = []

        # Act
        resp = await client.get("/lws/lambda/invocations/unknown-function")

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_invocations = resp.json()["Invocations"]
        assert (
            actual_invocations == expected_invocations
        ), f"Expected {expected_invocations!r} but got {actual_invocations!r}"

    async def test_function_name_reflected_in_response(self, client: AsyncClient) -> None:
        # Arrange
        expected_function = "test-fn"

        # Act
        resp = await client.get(f"/lws/lambda/invocations/{expected_function}")

        # Assert
        actual_function = resp.json()["FunctionName"]
        assert (
            actual_function == expected_function
        ), f"Expected {expected_function!r} but got {actual_function!r}"
