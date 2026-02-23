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
        # Arrange
        bucket_name = "my-bucket"
        expected_ok_status = 200
        expected_gone_status = 404
        await provider.create_bucket(bucket_name)
        await client.put(f"/{bucket_name}/key1", content=b"data1")
        await client.put(f"/{bucket_name}/key2", content=b"data2")
        await client.put(f"/{bucket_name}/key3", content=b"data3")

        delete_xml = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<Delete>"
            "<Object><Key>key1</Key></Object>"
            "<Object><Key>key2</Key></Object>"
            "</Delete>"
        )

        # Act
        resp = await client.post(
            f"/{bucket_name}?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_ok_status
        assert "<DeleteResult>" in resp.text
        assert "<Deleted><Key>key1</Key></Deleted>" in resp.text
        assert "<Deleted><Key>key2</Key></Deleted>" in resp.text

        get_resp = await client.get(f"/{bucket_name}/key3")
        assert get_resp.status_code == expected_ok_status

        get_resp1 = await client.get(f"/{bucket_name}/key1")
        assert get_resp1.status_code == expected_gone_status
        get_resp2 = await client.get(f"/{bucket_name}/key2")
        assert get_resp2.status_code == expected_gone_status

    @pytest.mark.asyncio
    async def test_delete_objects_nonexistent_keys(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        bucket_name = "my-bucket"
        await provider.create_bucket(bucket_name)
        expected_status = 200

        # Act
        delete_xml = "<Delete><Object><Key>nonexistent</Key></Object></Delete>"
        resp = await client.post(
            f"/{bucket_name}?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "<DeleteResult>" in resp.text
        # Nonexistent keys are still reported as deleted (S3 behavior)
        assert "<Deleted>" in resp.text

    @pytest.mark.asyncio
    async def test_delete_objects_malformed_xml(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("my-bucket")
        expected_status = 400

        # Act
        resp = await client.post(
            "/my-bucket?delete",
            content=b"not xml",
            headers={"content-type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "MalformedXML" in resp.text

    @pytest.mark.asyncio
    async def test_delete_objects_empty_list(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("my-bucket")
        expected_status = 200

        # Act
        delete_xml = "<Delete></Delete>"
        resp = await client.post(
            "/my-bucket?delete",
            content=delete_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "<DeleteResult>" in resp.text
