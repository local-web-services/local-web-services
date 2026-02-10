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
        await provider.create_bucket("src-bucket")
        await provider.create_bucket("dst-bucket")
        await client.put("/src-bucket/my-key", content=b"hello world")

        resp = await client.put(
            "/dst-bucket/copied-key",
            headers={"x-amz-copy-source": "/src-bucket/my-key"},
        )

        assert resp.status_code == 200
        assert "<CopyObjectResult>" in resp.text
        assert "<ETag>" in resp.text

        # Verify the copy actually landed
        get_resp = await client.get("/dst-bucket/copied-key")
        assert get_resp.status_code == 200
        assert get_resp.content == b"hello world"

    @pytest.mark.asyncio
    async def test_copy_object_same_bucket(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")
        await client.put("/my-bucket/original", content=b"data")

        resp = await client.put(
            "/my-bucket/duplicate",
            headers={"x-amz-copy-source": "/my-bucket/original"},
        )

        assert resp.status_code == 200
        get_resp = await client.get("/my-bucket/duplicate")
        assert get_resp.content == b"data"

    @pytest.mark.asyncio
    async def test_copy_object_source_not_found(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("src-bucket")
        await provider.create_bucket("dst-bucket")

        resp = await client.put(
            "/dst-bucket/copied-key",
            headers={"x-amz-copy-source": "/src-bucket/nonexistent"},
        )

        assert resp.status_code == 404
        assert "NoSuchKey" in resp.text

    @pytest.mark.asyncio
    async def test_copy_object_invalid_header(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("dst-bucket")

        resp = await client.put(
            "/dst-bucket/copied-key",
            headers={"x-amz-copy-source": "no-slash-bucket-only"},
        )

        assert resp.status_code == 400
        assert "InvalidArgument" in resp.text

    @pytest.mark.asyncio
    async def test_copy_object_without_header_is_regular_put(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.put("/my-bucket/regular-key", content=b"regular data")

        assert resp.status_code == 200
        get_resp = await client.get("/my-bucket/regular-key")
        assert get_resp.content == b"regular data"
