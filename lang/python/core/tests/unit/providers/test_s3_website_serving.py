"""Tests for S3 website index document resolution."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


@pytest.fixture
async def provider(tmp_path: Path):
    """Provider started with one bucket and website config."""
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


class TestIndexDocumentResolution:
    @pytest.mark.asyncio
    async def test_trailing_slash_serves_index_document(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website("web-bucket", {"index_document": "index.html"})
        await provider.put_object("web-bucket", "index.html", b"<html>root</html>")
        expected_body = b"<html>root</html>"

        # Act
        response = await client.get("/web-bucket/")

        # Assert
        assert response.status_code == 200
        actual_body = response.content
        assert actual_body == expected_body

    @pytest.mark.asyncio
    async def test_subdir_trailing_slash_serves_index_document(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website("web-bucket", {"index_document": "index.html"})
        await provider.put_object("web-bucket", "docs/index.html", b"<html>docs</html>")
        expected_body = b"<html>docs</html>"

        # Act
        response = await client.get("/web-bucket/docs/")

        # Assert
        assert response.status_code == 200
        actual_body = response.content
        assert actual_body == expected_body

    @pytest.mark.asyncio
    async def test_extensionless_path_serves_index_document(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website("web-bucket", {"index_document": "index.html"})
        await provider.put_object("web-bucket", "about/index.html", b"<html>about</html>")
        expected_body = b"<html>about</html>"

        # Act
        response = await client.get("/web-bucket/about")

        # Assert
        assert response.status_code == 200
        actual_body = response.content
        assert actual_body == expected_body

    @pytest.mark.asyncio
    async def test_no_website_config_returns_nosuchkey(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange (no website config set)
        expected_status = 404

        # Act
        response = await client.get("/web-bucket/missing")

        # Assert
        assert response.status_code == expected_status
        assert b"NoSuchKey" in response.content
