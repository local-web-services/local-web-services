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


class TestMetadataStorage:
    """Metadata sidecar persistence."""

    async def test_metadata_persists(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "key"
        body = b"val"
        expected_size = 3
        expected_etag = hashlib.md5(body).hexdigest()
        expected_content_type = "application/octet-stream"

        # Act
        await provider.put_object(bucket, key, body)
        actual_meta = await provider.storage.head_object(bucket, key)

        # Assert
        assert actual_meta is not None, "Expected value to be set but was None"
        assert actual_meta["size"] == expected_size, f'Expected {expected_size!r} but got {actual_meta["size"]!r}'
        assert actual_meta["etag"] == expected_etag, f'Expected {expected_etag!r} but got {actual_meta["etag"]!r}'
        assert actual_meta["content_type"] == expected_content_type, f'Expected {expected_content_type!r} but got {actual_meta["content_type"]!r}'
        assert actual_meta["last_modified"] != "", f'Expected values to differ but both were {actual_meta["last_modified"]!r}'
