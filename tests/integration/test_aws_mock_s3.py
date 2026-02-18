"""Integration tests for AWS mock on S3 (mock returns canned response)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers._shared.aws_operation_mock import (
    AwsMockConfig,
    AwsMockResponse,
    AwsMockRule,
)
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


class TestS3MockGetObject:
    """Verify mock middleware returns canned response for S3 GetObject."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create S3 provider with a test bucket."""
        p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def mock_config(self):
        """Create a mock config that returns a canned GetObject response."""
        return AwsMockConfig(
            service="s3",
            enabled=True,
            rules=[
                AwsMockRule(
                    operation="get-object",
                    response=AwsMockResponse(
                        status=200,
                        body="mocked file content",
                        content_type="text/plain",
                    ),
                ),
            ],
        )

    @pytest.fixture
    def app(self, provider, mock_config):
        """Create S3 app with mock enabled."""
        return create_s3_app(provider, aws_mock=mock_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_mock_returns_canned_get_object(self, client: httpx.AsyncClient):
        """Verify mocked GetObject returns canned body."""
        # Arrange
        expected_status = 200
        expected_body = "mocked file content"

        # Act
        response = await client.get("/test-bucket/test-key.txt")

        # Assert
        assert response.status_code == expected_status
        actual_body = response.text
        assert actual_body == expected_body

    async def test_unmocked_list_buckets_falls_through(self, client: httpx.AsyncClient):
        """Verify unmocked ListBuckets falls through to real provider."""
        # Arrange
        expected_status = 200

        # Act
        response = await client.get("/")

        # Assert
        assert response.status_code == expected_status
        assert "test-bucket" in response.text
