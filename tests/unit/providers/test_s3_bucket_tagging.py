"""Tests for S3 PutBucketTagging / GetBucketTagging / DeleteBucketTagging operations."""

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


class TestBucketTagging:
    @pytest.mark.asyncio
    async def test_put_and_get_bucket_tagging(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        tagging_xml = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<Tagging>"
            "<TagSet>"
            "<Tag><Key>env</Key><Value>production</Value></Tag>"
            "<Tag><Key>team</Key><Value>platform</Value></Tag>"
            "</TagSet>"
            "</Tagging>"
        )
        put_resp = await client.put(
            "/my-bucket?tagging",
            content=tagging_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        assert put_resp.status_code == 204

        get_resp = await client.get("/my-bucket?tagging")
        assert get_resp.status_code == 200
        assert "<Tagging>" in get_resp.text
        assert "<Key>env</Key>" in get_resp.text
        assert "<Value>production</Value>" in get_resp.text
        assert "<Key>team</Key>" in get_resp.text
        assert "<Value>platform</Value>" in get_resp.text

    @pytest.mark.asyncio
    async def test_get_bucket_tagging_empty(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.get("/my-bucket?tagging")

        assert resp.status_code == 200
        assert "<Tagging>" in resp.text
        assert "<TagSet>" in resp.text

    @pytest.mark.asyncio
    async def test_delete_bucket_tagging(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        tagging_xml = (
            "<Tagging><TagSet><Tag><Key>env</Key><Value>staging</Value></Tag></TagSet></Tagging>"
        )
        await client.put(
            "/my-bucket?tagging",
            content=tagging_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        delete_resp = await client.delete("/my-bucket?tagging")
        assert delete_resp.status_code == 204

        # Tags should be gone
        get_resp = await client.get("/my-bucket?tagging")
        assert get_resp.status_code == 200
        # TagSet should be empty (no <Tag> elements)
        assert "<Tag>" not in get_resp.text

    @pytest.mark.asyncio
    async def test_put_bucket_tagging_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        tagging_xml = (
            "<Tagging><TagSet><Tag><Key>env</Key><Value>dev</Value></Tag></TagSet></Tagging>"
        )
        resp = await client.put(
            "/nonexistent-bucket?tagging",
            content=tagging_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 404
        assert "NoSuchBucket" in resp.text

    @pytest.mark.asyncio
    async def test_delete_bucket_tagging_no_such_bucket(self, client: httpx.AsyncClient) -> None:
        resp = await client.delete("/nonexistent-bucket?tagging")

        assert resp.status_code == 404
        assert "NoSuchBucket" in resp.text

    @pytest.mark.asyncio
    async def test_put_bucket_tagging_malformed_xml(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.put(
            "/my-bucket?tagging",
            content=b"not valid xml",
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 400
        assert "MalformedXML" in resp.text
