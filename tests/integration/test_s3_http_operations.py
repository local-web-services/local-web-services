"""Integration tests for the S3 HTTP wire protocol."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from ldk.providers.s3.provider import S3Provider
from ldk.providers.s3.routes import create_s3_app


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_s3_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestS3HttpOperations:
    async def test_put_and_get_object(self, client: httpx.AsyncClient):
        put_resp = await client.put(
            "/test-bucket/my-key",
            content=b"hello s3",
        )
        assert put_resp.status_code == 200

        get_resp = await client.get("/test-bucket/my-key")
        assert get_resp.status_code == 200
        assert get_resp.content == b"hello s3"

    async def test_delete_object(self, client: httpx.AsyncClient):
        await client.put("/test-bucket/del-key", content=b"bye")

        del_resp = await client.delete("/test-bucket/del-key")
        assert del_resp.status_code == 204

        get_resp = await client.get("/test-bucket/del-key")
        assert get_resp.status_code == 404

    async def test_head_object(self, client: httpx.AsyncClient):
        await client.put("/test-bucket/head-key", content=b"12345")

        head_resp = await client.head("/test-bucket/head-key")
        assert head_resp.status_code == 200
        assert head_resp.headers["content-length"] == "5"

    async def test_list_objects(self, client: httpx.AsyncClient):
        await client.put("/test-bucket/list/a.txt", content=b"aaa")
        await client.put("/test-bucket/list/b.txt", content=b"bbb")

        list_resp = await client.get("/test-bucket", params={"list-type": "2"})
        assert list_resp.status_code == 200
        assert "<Key>list/a.txt</Key>" in list_resp.text
        assert "<Key>list/b.txt</Key>" in list_resp.text
