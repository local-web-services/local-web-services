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
        # Arrange
        bucket_name = "my-bucket"
        await provider.create_bucket(bucket_name)
        expected_put_status = 204
        expected_get_status = 200
        expected_content_type = "application/json"

        policy = (
            '{"Version":"2012-10-17","Statement":'
            '[{"Effect":"Allow","Principal":"*",'
            '"Action":"s3:GetObject",'
            '"Resource":"arn:aws:s3:::my-bucket/*"}]}'
        )
        put_resp = await client.put(
            f"/{bucket_name}?policy",
            content=policy.encode(),
            headers={"content-type": expected_content_type},
        )

        # Act
        get_resp = await client.get(f"/{bucket_name}?policy")

        # Assert
        assert put_resp.status_code == expected_put_status
        assert get_resp.status_code == expected_get_status
        assert "s3:GetObject" in get_resp.text
        assert get_resp.headers["content-type"] == expected_content_type

    @pytest.mark.asyncio
    async def test_get_bucket_policy_default(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("my-bucket")
        expected_status = 200

        # Act
        resp = await client.get("/my-bucket?policy")

        # Assert
        assert resp.status_code == expected_status
        assert "2012-10-17" in resp.text
        assert "Statement" in resp.text

    @pytest.mark.asyncio
    async def test_put_bucket_policy_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await client.put(
            "/nonexistent-bucket?policy",
            content=b'{"Version":"2012-10-17","Statement":[]}',
            headers={"content-type": "application/json"},
        )

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        assert "NoSuchBucket" in resp.text

    @pytest.mark.asyncio
    async def test_get_bucket_policy_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await client.get("/nonexistent-bucket?policy")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        assert "NoSuchBucket" in resp.text
