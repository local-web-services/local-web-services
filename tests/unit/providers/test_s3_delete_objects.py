"""Tests for S3 DeleteObjects (multi-object delete) operation."""

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


class TestDeleteObjects:
    @pytest.mark.asyncio
    async def test_delete_objects_success(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")
        await client.put("/my-bucket/key1", content=b"data1")
        await client.put("/my-bucket/key2", content=b"data2")
        await client.put("/my-bucket/key3", content=b"data3")

        delete_xml = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<Delete>"
            "<Object><Key>key1</Key></Object>"
            "<Object><Key>key2</Key></Object>"
            "</Delete>"
        )
        resp = await client.post(
            "/my-bucket?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 200
        assert "<DeleteResult>" in resp.text
        assert "<Deleted><Key>key1</Key></Deleted>" in resp.text
        assert "<Deleted><Key>key2</Key></Deleted>" in resp.text

        # key3 should still exist
        get_resp = await client.get("/my-bucket/key3")
        assert get_resp.status_code == 200

        # key1 and key2 should be gone
        get_resp1 = await client.get("/my-bucket/key1")
        assert get_resp1.status_code == 404
        get_resp2 = await client.get("/my-bucket/key2")
        assert get_resp2.status_code == 404

    @pytest.mark.asyncio
    async def test_delete_objects_nonexistent_keys(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        delete_xml = "<Delete><Object><Key>nonexistent</Key></Object></Delete>"
        resp = await client.post(
            "/my-bucket?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 200
        assert "<DeleteResult>" in resp.text
        # Nonexistent keys are still reported as deleted (S3 behavior)
        assert "<Deleted>" in resp.text

    @pytest.mark.asyncio
    async def test_delete_objects_malformed_xml(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        resp = await client.post(
            "/my-bucket?delete",
            content=b"not xml",
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 400
        assert "MalformedXML" in resp.text

    @pytest.mark.asyncio
    async def test_delete_objects_empty_list(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        await provider.create_bucket("my-bucket")

        delete_xml = "<Delete></Delete>"
        resp = await client.post(
            "/my-bucket?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        assert resp.status_code == 200
        assert "<DeleteResult>" in resp.text
