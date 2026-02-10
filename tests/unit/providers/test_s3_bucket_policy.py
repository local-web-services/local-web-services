"""Tests for S3 PutBucketPolicy / GetBucketPolicy operations."""

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


class TestBucketPolicy:
    @pytest.mark.asyncio
    async def test_put_and_get_bucket_policy(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        policy = (
            '{"Version":"2012-10-17","Statement":'
            '[{"Effect":"Allow","Principal":"*",'
            '"Action":"s3:GetObject",'
            '"Resource":"arn:aws:s3:::my-bucket/*"}]}'
        )
        put_resp = await client.put(
            "/my-bucket?policy",
            content=policy.encode(),
            headers={"content-type": "application/json"},
        )

        assert put_resp.status_code == 204

        get_resp = await client.get("/my-bucket?policy")
        assert get_resp.status_code == 200
        assert "s3:GetObject" in get_resp.text
        assert get_resp.headers["content-type"] == "application/json"

    @pytest.mark.asyncio
    async def test_get_bucket_policy_default(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.get("/my-bucket?policy")

        assert resp.status_code == 200
        assert "2012-10-17" in resp.text
        assert "Statement" in resp.text

    @pytest.mark.asyncio
    async def test_put_bucket_policy_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        resp = await client.put(
            "/nonexistent-bucket?policy",
            content=b'{"Version":"2012-10-17","Statement":[]}',
            headers={"content-type": "application/json"},
        )

        assert resp.status_code == 404
        assert "NoSuchBucket" in resp.text

    @pytest.mark.asyncio
    async def test_get_bucket_policy_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        resp = await client.get("/nonexistent-bucket?policy")

        assert resp.status_code == 404
        assert "NoSuchBucket" in resp.text
