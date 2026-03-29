"""Tests that Lambda routes return TooManyRequestsException when capacity is exhausted."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry
from lws.providers.lambda_runtime.routes import create_lambda_management_app

_FUNCTION_NAME = "my-function"


def _make_fake_compute() -> ICompute:
    """Return a fake ICompute that returns an empty result."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload={},
        error=None,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


class TestLambdaRoutesCapacityExhausted:
    """Lambda invocation routes return 429 when capacity slots=0."""

    @pytest.mark.asyncio
    async def test_sync_invoke_capacity_exhausted(self) -> None:
        # Arrange
        registry = LambdaRegistry()
        capacity = AwsCapacityConfig(slots=0)
        app = create_lambda_management_app(registry=registry, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 429
        expected_error_type = "TooManyRequestsException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                f"/2015-03-31/functions/{_FUNCTION_NAME}/invocations",
                json={},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_async_invoke_capacity_exhausted(self) -> None:
        # Arrange
        registry = LambdaRegistry()
        registry.register(_FUNCTION_NAME, {"FunctionName": _FUNCTION_NAME}, _make_fake_compute())
        async_capacity = AwsCapacityConfig(slots=0)
        app = create_lambda_management_app(registry=registry, async_capacity=async_capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 429
        expected_error_type = "TooManyRequestsException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                f"/2015-03-31/functions/{_FUNCTION_NAME}/invocations",
                json={},
                headers={"X-Amz-Invocation-Type": "Event"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
