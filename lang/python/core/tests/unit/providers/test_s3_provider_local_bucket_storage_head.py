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


class TestLocalBucketStorageHead:
    """head_object tests."""

    async def test_head_existing(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "key"
        body = b"content"
        expected_size = 7

        # Act
        await storage.put_object(bucket, key, body)
        actual_meta = await storage.head_object(bucket, key)

        # Assert
        assert actual_meta is not None
        assert actual_meta["size"] == expected_size
        assert "body" not in actual_meta

    async def test_head_nonexistent(self, storage: LocalBucketStorage) -> None:
        # Act
        actual_result = await storage.head_object("mybucket", "nokey")

        # Assert
        assert actual_result is None
