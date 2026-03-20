"""Integration tests for AWS fake on S3 (fake returns canned response)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeResponse,
    AwsFakeRule,
)
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


class TestS3FakeGetObject:
    """Verify fake middleware returns canned response for S3 GetObject."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create S3 provider with a test bucket."""
        p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def fake_config(self):
        """Create a fake config that returns a canned GetObject response."""
        return AwsFakeConfig(
            service="s3",
            enabled=True,
            rules=[
                AwsFakeRule(
                    operation="get-object",
                    response=AwsFakeResponse(
                        status=200,
                        body="faked file content",
                        content_type="text/plain",
                    ),
                ),
            ],
        )

    @pytest.fixture
    def app(self, provider, fake_config):
        """Create S3 app with fake enabled."""
        return create_s3_app(provider, aws_fake=fake_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_fake_returns_canned_get_object(self, client: httpx.AsyncClient):
        """Verify faked GetObject returns canned body."""
        # Arrange
        expected_status = 200
        expected_body = "faked file content"

        # Act
        response = await client.get("/test-bucket/test-key.txt")

        # Assert
        assert response.status_code == expected_status, f"Expected {expected_status!r} but got {response.status_code!r}"
        actual_body = response.text
        assert actual_body == expected_body, f"Expected {expected_body!r} but got {actual_body!r}"

    async def test_unfaked_list_buckets_falls_through(self, client: httpx.AsyncClient):
        """Verify unfaked ListBuckets falls through to real provider."""
        # Arrange
        expected_status = 200

        # Act
        response = await client.get("/")

        # Assert
        assert response.status_code == expected_status, f"Expected {expected_status!r} but got {response.status_code!r}"
        assert "test-bucket" in response.text, f'Expected {"test-bucket"!r} to be in {response.text!r}'
