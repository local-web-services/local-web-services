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
        # Arrange
        bucket = "mybucket"
        key = "greeting.txt"
        body = b"hello world"
        expected_etag = hashlib.md5(body).hexdigest()
        expected_content_type = "application/octet-stream"

        # Act
        result = await storage.put_object(bucket, key, body)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert "ETag" in result
        assert result["ETag"] == f'"{expected_etag}"'
        assert actual_obj is not None
        assert actual_obj["body"] == body
        assert actual_obj["content_type"] == expected_content_type
        assert actual_obj["size"] == len(body)
        assert actual_obj["etag"] == expected_etag

    async def test_put_with_content_type(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "data.json"
        expected_content_type = "application/json"

        # Act
        await storage.put_object(bucket, key, b'{"a":1}', content_type=expected_content_type)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert actual_obj is not None
        assert actual_obj["content_type"] == expected_content_type

    async def test_put_with_metadata(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "tagged.txt"
        expected_metadata = {"x-amz-meta-author": "test"}

        # Act
        await storage.put_object(bucket, key, b"data", metadata=expected_metadata)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert actual_obj is not None
        assert actual_obj["metadata"] == expected_metadata

    async def test_get_nonexistent_returns_none(self, storage: LocalBucketStorage) -> None:
        result = await storage.get_object("nobucket", "nokey")
        assert result is None

    async def test_put_overwrites_existing(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "key"
        expected_body = b"version2"
        await storage.put_object(bucket, key, b"version1")

        # Act
        await storage.put_object(bucket, key, expected_body)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert actual_obj is not None
        assert actual_obj["body"] == expected_body

    async def test_nested_key(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        key = "a/b/c/deep.txt"
        expected_body = b"deep"

        # Act
        await storage.put_object(bucket, key, expected_body)
        actual_obj = await storage.get_object(bucket, key)

        # Assert
        assert actual_obj is not None
        assert actual_obj["body"] == expected_body
