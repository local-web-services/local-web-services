"""Tests for S3 route-level bucket management operations."""

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


class TestDeleteBucket:
    @pytest.mark.asyncio
    async def test_delete_bucket_success(
        self,
        client: httpx.AsyncClient,
        provider: S3Provider,
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.delete("/my-bucket")

        assert resp.status_code == 204

    @pytest.mark.asyncio
    async def test_delete_bucket_not_found(self, client: httpx.AsyncClient) -> None:
        resp = await client.delete("/nonexistent")

        assert resp.status_code == 404
        assert "NoSuchBucket" in resp.text
