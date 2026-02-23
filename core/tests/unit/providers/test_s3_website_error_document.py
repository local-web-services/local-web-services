"""Tests for S3 website error document serving."""

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


class TestErrorDocumentServing:
    @pytest.mark.asyncio
    async def test_missing_key_serves_error_document(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website(
            "web-bucket",
            {"index_document": "index.html", "error_document": "404.html"},
        )
        await provider.put_object("web-bucket", "404.html", b"<html>not found</html>")
        expected_status = 404
        expected_body = b"<html>not found</html>"

        # Act
        response = await client.get("/web-bucket/nonexistent.txt")

        # Assert
        assert response.status_code == expected_status
        actual_body = response.content
        assert actual_body == expected_body

    @pytest.mark.asyncio
    async def test_missing_key_no_error_document_returns_nosuchkey(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        provider.put_bucket_website("web-bucket", {"index_document": "index.html"})
        expected_status = 404

        # Act
        response = await client.get("/web-bucket/nonexistent.txt")

        # Assert
        assert response.status_code == expected_status
        assert b"NoSuchKey" in response.content

    @pytest.mark.asyncio
    async def test_missing_error_document_returns_nosuchkey(
        self, provider: S3Provider, client: httpx.AsyncClient
    ) -> None:
        # Arrange — error_document configured but file doesn't exist
        provider.put_bucket_website(
            "web-bucket",
            {"index_document": "index.html", "error_document": "404.html"},
        )
        expected_status = 404

        # Act
        response = await client.get("/web-bucket/nonexistent.txt")

        # Assert
        assert response.status_code == expected_status
        assert b"NoSuchKey" in response.content
