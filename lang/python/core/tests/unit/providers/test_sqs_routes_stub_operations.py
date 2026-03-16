"""Tests for SQS stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sqs.provider import SqsProvider
from lws.providers.sqs.routes import create_sqs_app


class TestSqsStubOperations:
    """Test SQS returns proper errors for unknown operations."""

    @pytest.fixture
    async def provider(self):
        """Create and start an SQS provider."""
        p = SqsProvider()
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def client(self, provider):
        """Create an HTTP client for the SQS app."""
        app = create_sqs_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_json_operation_returns_error(self, client):
        """Test that unknown JSON operations return HTTP 400 with UnknownOperationException."""
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"
        action_name = "AddPermission"

        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"X-Amz-Target": f"AmazonSQS.{action_name}"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert "lws" in body["message"]
        assert "SQS" in body["message"]
        assert action_name in body["message"]

    @pytest.mark.asyncio
    async def test_unknown_xml_operation_returns_error(self, client):
        """Test that unknown XML operations return HTTP 400 with ErrorResponse XML."""
        # Arrange
        expected_status_code = 400
        action_name = "AddPermission"

        # Act
        resp = await client.post(
            "/",
            data={"Action": action_name},
            headers={"Content-Type": "application/x-www-form-urlencoded"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        assert "<ErrorResponse>" in resp.text
        assert "<Code>InvalidAction</Code>" in resp.text
        assert "lws" in resp.text
        assert "SQS" in resp.text
        assert action_name in resp.text
