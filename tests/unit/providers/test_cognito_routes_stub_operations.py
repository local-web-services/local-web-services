"""Tests for Cognito stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig


class TestCognitoStubOperations:
    """Test Cognito returns proper errors for unknown operations."""

    @pytest.fixture
    def client(self, tmp_path):
        """Create an HTTP client for the Cognito app."""
        config = UserPoolConfig(
            user_pool_id="us-east-1_test",
            user_pool_name="test",
        )
        provider = CognitoProvider(data_dir=tmp_path, config=config)
        app = create_cognito_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_operation_returns_error(self, client):
        """Test that unknown operations return HTTP 400 with UnknownOperationException."""
        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"X-Amz-Target": "AWSCognitoIdentityProviderService.TagResource"},
        )

        # Assert
        expected_status = 400
        expected_error_type = "UnknownOperationException"
        assert resp.status_code == expected_status
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert "lws" in body["message"]
        assert "Cognito" in body["message"]
        assert "TagResource" in body["message"]
