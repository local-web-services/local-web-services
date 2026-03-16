"""Tests for S3 website-enabled bucket serving existing objects normally."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


@pytest.fixture
async def provider(tmp_path: Path):
    """Provider started with one bucket."""
    p = S3Provider(data_dir=tmp_path, buckets=["web-bucket"])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    """Create S3 app."""
    return create_s3_app(provider)


@pytest.fixture
async def client(app):
    """Create async HTTP client."""
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestExistingObjectNotAffected:
    @pytest.mark.asyncio
    async def test_existing_object_served_normally(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website("web-bucket", {"index_document": "index.html"})
        await provider.put_object("web-bucket", "style.css", b"body { color: red; }")
        expected_body = b"body { color: red; }"

        # Act
        response = await client.get("/web-bucket/style.css")

        # Assert
        assert response.status_code == 200
        actual_body = response.content
        assert actual_body == expected_body
