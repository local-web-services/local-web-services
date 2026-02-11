"""Tests for S3 GetBucketLocation operation."""

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


class TestGetBucketLocation:
    @pytest.mark.asyncio
    async def test_get_bucket_location(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("my-bucket")
        expected_status = 200
        expected_location_xml = "<LocationConstraint>us-east-1</LocationConstraint>"

        # Act
        resp = await client.get("/my-bucket?location")

        # Assert
        assert resp.status_code == expected_status
        assert expected_location_xml in resp.text

    @pytest.mark.asyncio
    async def test_get_bucket_location_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await client.get("/nonexistent-bucket?location")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        assert "NoSuchBucket" in resp.text
