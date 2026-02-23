"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

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


class TestLocalBucketStorageDelete:
    """delete_object tests."""

    async def test_delete_existing(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "key"
        await storage.put_object(bucket, key, b"data")

        # Act
        actual_existed = await storage.delete_object(bucket, key)

        # Assert
        assert actual_existed is True
        assert await storage.get_object(bucket, key) is None

    async def test_delete_nonexistent(self, storage: LocalBucketStorage) -> None:
        # Act
        actual_existed = await storage.delete_object("mybucket", "nokey")

        # Assert
        assert actual_existed is False

    async def test_delete_removes_metadata(self, storage: LocalBucketStorage, tmp_path: Path):
        # Arrange
        bucket = "mybucket"
        key = "key"
        await storage.put_object(bucket, key, b"data")
        meta_path = tmp_path / "s3" / ".metadata" / bucket / "key.json"
        assert meta_path.exists()

        # Act
        await storage.delete_object(bucket, key)

        # Assert
        assert not meta_path.exists()
