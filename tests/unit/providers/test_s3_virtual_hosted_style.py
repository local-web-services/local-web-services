"""Tests for S3 virtual-hosted-style request rewriting."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path)
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: S3Provider) -> httpx.AsyncClient:
    app = create_s3_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestVirtualHostedStyle:
    """Tests for virtual-hosted-style S3 request rewriting."""

    @pytest.mark.asyncio
    async def test_put_object_via_virtual_hosted_style(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        expected_key = "my-key.txt"
        expected_body = b"hello virtual hosted"
        await provider.create_bucket(expected_bucket)

        # Act
        resp = await client.put(
            f"/{expected_key}",
            content=expected_body,
            headers={"host": f"{expected_bucket}.host.docker.internal:3003"},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        result = await provider.storage.get_object(expected_bucket, expected_key)
        assert result is not None
        assert result["body"] == expected_body

    @pytest.mark.asyncio
    async def test_get_object_via_virtual_hosted_style(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        expected_key = "doc.txt"
        expected_body = b"content here"
        await provider.create_bucket(expected_bucket)
        await provider.storage.put_object(expected_bucket, expected_key, expected_body)

        # Act
        resp = await client.get(
            f"/{expected_key}",
            headers={"host": f"{expected_bucket}.host.docker.internal:3003"},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert resp.content == expected_body

    @pytest.mark.asyncio
    async def test_head_bucket_via_virtual_hosted_style(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        await provider.create_bucket(expected_bucket)

        # Act
        resp = await client.head(
            "/",
            headers={"host": f"{expected_bucket}.host.docker.internal:3003"},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status

    @pytest.mark.asyncio
    async def test_path_style_still_works(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        await provider.create_bucket(expected_bucket)

        # Act
        resp = await client.head(f"/{expected_bucket}")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status

    @pytest.mark.asyncio
    async def test_localhost_virtual_hosted_style(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        expected_key = "file.txt"
        expected_body = b"localhost test"
        await provider.create_bucket(expected_bucket)

        # Act
        resp = await client.put(
            f"/{expected_key}",
            content=expected_body,
            headers={"host": f"{expected_bucket}.localhost:3003"},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        result = await provider.storage.get_object(expected_bucket, expected_key)
        assert result is not None
        assert result["body"] == expected_body
