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
        assert put_resp.status_code == expected_put_status, f"Expected {expected_put_status!r} but got {put_resp.status_code!r}"
        assert get_resp.status_code == expected_get_status, f"Expected {expected_get_status!r} but got {get_resp.status_code!r}"
        assert "s3:GetObject" in get_resp.text, f'Expected {"s3:GetObject"!r} to be in {get_resp.text!r}'
        assert get_resp.headers["content-type"] == expected_content_type, f'Expected {expected_content_type!r} but got {get_resp.headers["content-type"]!r}'

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
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "2012-10-17" in resp.text, f'Expected {"2012-10-17"!r} to be in {resp.text!r}'
        assert "Statement" in resp.text, f'Expected {"Statement"!r} to be in {resp.text!r}'

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
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "NoSuchBucket" in resp.text, f'Expected {"NoSuchBucket"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_get_bucket_policy_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await client.get("/nonexistent-bucket?policy")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "NoSuchBucket" in resp.text, f'Expected {"NoSuchBucket"!r} to be in {resp.text!r}'
