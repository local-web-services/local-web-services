"""Tests for S3 CopyObject operation."""

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


class TestCopyObject:
    @pytest.mark.asyncio
    async def test_copy_object_success(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        src_bucket = "src-bucket"
        dst_bucket = "dst-bucket"
        expected_body = b"hello world"
        expected_status = 200
        await provider.create_bucket(src_bucket)
        await provider.create_bucket(dst_bucket)
        await client.put(f"/{src_bucket}/my-key", content=expected_body)

        # Act
        resp = await client.put(
            f"/{dst_bucket}/copied-key",
            headers={"x-amz-copy-source": f"/{src_bucket}/my-key"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "<CopyObjectResult>" in resp.text
        assert "<ETag>" in resp.text
        get_resp = await client.get(f"/{dst_bucket}/copied-key")
        assert get_resp.status_code == expected_status
        assert get_resp.content == expected_body

    @pytest.mark.asyncio
    async def test_copy_object_same_bucket(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        bucket_name = "my-bucket"
        expected_body = b"data"
        expected_status = 200
        await provider.create_bucket(bucket_name)
        await client.put(f"/{bucket_name}/original", content=expected_body)

        # Act
        resp = await client.put(
            f"/{bucket_name}/duplicate",
            headers={"x-amz-copy-source": f"/{bucket_name}/original"},
        )

        # Assert
        assert resp.status_code == expected_status
        get_resp = await client.get(f"/{bucket_name}/duplicate")
        assert get_resp.content == expected_body

    @pytest.mark.asyncio
    async def test_copy_object_source_not_found(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("src-bucket")
        await provider.create_bucket("dst-bucket")
        expected_status = 404

        # Act
        resp = await client.put(
            "/dst-bucket/copied-key",
            headers={"x-amz-copy-source": "/src-bucket/nonexistent"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "NoSuchKey" in resp.text

    @pytest.mark.asyncio
    async def test_copy_object_invalid_header(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("dst-bucket")
        expected_status = 400

        # Act
        resp = await client.put(
            "/dst-bucket/copied-key",
            headers={"x-amz-copy-source": "no-slash-bucket-only"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "InvalidArgument" in resp.text

    @pytest.mark.asyncio
    async def test_copy_object_without_header_is_regular_put(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        bucket_name = "my-bucket"
        expected_body = b"regular data"
        expected_status = 200
        await provider.create_bucket(bucket_name)

        # Act
        resp = await client.put(f"/{bucket_name}/regular-key", content=expected_body)

        # Assert
        assert resp.status_code == expected_status
        get_resp = await client.get(f"/{bucket_name}/regular-key")
        assert get_resp.content == expected_body
