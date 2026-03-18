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


class TestListBuckets:
    @pytest.mark.asyncio
    async def test_list_buckets(self, client: httpx.AsyncClient, provider: S3Provider) -> None:
        # Arrange
        bucket_a = "bucket-a"
        bucket_b = "bucket-b"
        await provider.create_bucket(bucket_a)
        await provider.create_bucket(bucket_b)
        expected_status = 200

        # Act
        resp = await client.get("/")

        # Assert
        assert resp.status_code == expected_status
        assert "ListAllMyBucketsResult" in resp.text
        assert bucket_a in resp.text
        assert bucket_b in resp.text

    @pytest.mark.asyncio
    async def test_list_buckets_empty(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await client.get("/")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert "ListAllMyBucketsResult" in resp.text
