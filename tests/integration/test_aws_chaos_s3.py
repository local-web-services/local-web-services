"""Integration tests for AWS chaos injection on S3 (XML format)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsErrorSpec
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


class TestS3ChaosXmlFormat:
    """Verify chaos middleware injects S3-style XML error responses."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create S3 provider."""
        p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def chaos_config(self):
        """Create a chaos config that always injects errors."""
        return AwsChaosConfig(
            enabled=True,
            error_rate=1.0,
            errors=[
                AwsErrorSpec(
                    type="NoSuchKey",
                    message="The specified key does not exist.",
                    weight=1.0,
                )
            ],
        )

    @pytest.fixture
    def app(self, provider, chaos_config):
        """Create S3 app with chaos enabled."""
        return create_s3_app(provider, chaos=chaos_config)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_chaos_injects_s3_xml_error(self, client: httpx.AsyncClient):
        """Verify chaos injects a properly formatted S3 XML error."""
        # Arrange
        expected_status = 404
        expected_code = "NoSuchKey"

        # Act
        response = await client.get("/test-bucket/some-key")

        # Assert
        assert response.status_code == expected_status
        body = response.text
        assert f"<Code>{expected_code}</Code>" in body
        assert "<Message>The specified key does not exist.</Message>" in body

    async def test_chaos_disabled_passes_through(self, provider, chaos_config, tmp_path):
        """Verify S3 requests pass through when chaos is disabled."""
        # Arrange
        chaos_config.enabled = False
        app = create_s3_app(provider, chaos=chaos_config)
        transport = httpx.ASGITransport(app=app)
        expected_status = 200

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            response = await c.put(
                "/test-bucket/test-key",
                content=b"hello",
                headers={"Content-Type": "text/plain"},
            )

        # Assert
        assert response.status_code == expected_status
