"""Tests for Step Functions stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.stepfunctions.provider import StepFunctionsProvider
from lws.providers.stepfunctions.routes import create_stepfunctions_app


class TestStepFunctionsStubOperations:
    """Test Step Functions returns proper errors for unknown operations."""

    @pytest.fixture
    async def provider(self):
        """Create and start a Step Functions provider."""
        p = StepFunctionsProvider()
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def client(self, provider):
        """Create an HTTP client for the Step Functions app."""
        app = create_stepfunctions_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_operation_returns_error(self, client):
        """Test that unknown operations return HTTP 400 with UnknownOperationException."""
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"

        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSStepFunctions.SendTaskSuccess"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert "lws" in body["message"]
        assert "StepFunctions" in body["message"]
        assert "SendTaskSuccess" in body["message"]
