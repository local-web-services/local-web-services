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


class TestETagComputation:
    """Verify ETag is computed as MD5 hex digest."""

    async def test_etag_matches_md5(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "etag-test"
        body = b"specific content for etag test"
        expected_etag = hashlib.md5(body).hexdigest()

        # Act
        result = await storage.put_object(bucket, key, body)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert result["ETag"] == f'"{expected_etag}"'
        assert actual_obj is not None
        assert actual_obj["etag"] == expected_etag

    async def test_different_content_different_etag(self, storage: LocalBucketStorage) -> None:
        r1 = await storage.put_object("mybucket", "k1", b"aaa")
        r2 = await storage.put_object("mybucket", "k2", b"bbb")
        assert r1["ETag"] != r2["ETag"]
