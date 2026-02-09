"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

import hashlib
from pathlib import Path

import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.storage import LocalBucketStorage

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture
async def storage(tmp_path: Path) -> LocalBucketStorage:
    """Create a LocalBucketStorage instance."""
    return LocalBucketStorage(tmp_path)


@pytest.fixture
async def provider(tmp_path: Path) -> S3Provider:
    """Create, start, yield, and stop an S3Provider."""
    p = S3Provider(data_dir=tmp_path, buckets=["test-bucket", "other-bucket"])
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P1-12: LocalBucketStorage
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-14: S3Provider lifecycle and IObjectStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-15: NotificationDispatcher
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-16: Presigned URLs
# ---------------------------------------------------------------------------


class TestLocalBucketStoragePutGet:
    """put_object / get_object round-trip tests."""

    async def test_put_and_get_round_trip(self, storage: LocalBucketStorage) -> None:
        body = b"hello world"
        result = await storage.put_object("mybucket", "greeting.txt", body)

        assert "ETag" in result
        expected_etag = hashlib.md5(body).hexdigest()
        assert result["ETag"] == f'"{expected_etag}"'

        obj = await storage.get_object("mybucket", "greeting.txt")
        assert obj is not None
        assert obj["body"] == body
        assert obj["content_type"] == "application/octet-stream"
        assert obj["size"] == len(body)
        assert obj["etag"] == expected_etag

    async def test_put_with_content_type(self, storage: LocalBucketStorage) -> None:
        await storage.put_object(
            "mybucket", "data.json", b'{"a":1}', content_type="application/json"
        )
        obj = await storage.get_object("mybucket", "data.json")
        assert obj is not None
        assert obj["content_type"] == "application/json"

    async def test_put_with_metadata(self, storage: LocalBucketStorage) -> None:
        await storage.put_object(
            "mybucket",
            "tagged.txt",
            b"data",
            metadata={"x-amz-meta-author": "test"},
        )
        obj = await storage.get_object("mybucket", "tagged.txt")
        assert obj is not None
        assert obj["metadata"] == {"x-amz-meta-author": "test"}

    async def test_get_nonexistent_returns_none(self, storage: LocalBucketStorage) -> None:
        result = await storage.get_object("nobucket", "nokey")
        assert result is None

    async def test_put_overwrites_existing(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "key", b"version1")
        await storage.put_object("mybucket", "key", b"version2")
        obj = await storage.get_object("mybucket", "key")
        assert obj is not None
        assert obj["body"] == b"version2"

    async def test_nested_key(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "a/b/c/deep.txt", b"deep")
        obj = await storage.get_object("mybucket", "a/b/c/deep.txt")
        assert obj is not None
        assert obj["body"] == b"deep"
