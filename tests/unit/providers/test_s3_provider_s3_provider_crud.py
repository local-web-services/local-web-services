"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

from pathlib import Path

import pytest

from ldk.providers.s3.provider import S3Provider
from ldk.providers.s3.storage import LocalBucketStorage

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


class TestS3ProviderCRUD:
    """IObjectStore CRUD via S3Provider."""

    async def test_put_and_get(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "hello.txt", b"hello")
        result = await provider.get_object("test-bucket", "hello.txt")
        assert result == b"hello"

    async def test_get_nonexistent(self, provider: S3Provider) -> None:
        result = await provider.get_object("test-bucket", "nope")
        assert result is None

    async def test_delete(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "temp.txt", b"temp")
        await provider.delete_object("test-bucket", "temp.txt")
        assert await provider.get_object("test-bucket", "temp.txt") is None

    async def test_list_objects(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "a.txt", b"a")
        await provider.put_object("test-bucket", "b.txt", b"b")
        keys = await provider.list_objects("test-bucket")
        assert sorted(keys) == ["a.txt", "b.txt"]

    async def test_list_objects_with_prefix(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "logs/one.log", b"1")
        await provider.put_object("test-bucket", "logs/two.log", b"2")
        await provider.put_object("test-bucket", "data/file.txt", b"3")
        keys = await provider.list_objects("test-bucket", prefix="logs/")
        assert sorted(keys) == ["logs/one.log", "logs/two.log"]

    async def test_put_with_content_type(self, provider: S3Provider) -> None:
        await provider.put_object(
            "test-bucket", "data.json", b"{}", content_type="application/json"
        )
        # Verify via storage
        obj = await provider.storage.get_object("test-bucket", "data.json")
        assert obj is not None
        assert obj["content_type"] == "application/json"
