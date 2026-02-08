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


class TestLocalBucketStorageHead:
    """head_object tests."""

    async def test_head_existing(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "key", b"content")
        meta = await storage.head_object("mybucket", "key")
        assert meta is not None
        assert meta["size"] == 7
        assert "body" not in meta

    async def test_head_nonexistent(self, storage: LocalBucketStorage) -> None:
        result = await storage.head_object("mybucket", "nokey")
        assert result is None
