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


class TestS3ProviderCRUD:
    """IObjectStore CRUD via S3Provider."""

    async def test_put_and_get(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "hello.txt"
        expected_body = b"hello"

        # Act
        await provider.put_object(bucket, key, expected_body)
        actual_result = await provider.get_object(bucket, key)

        # Assert
        assert actual_result == expected_body

    async def test_get_nonexistent(self, provider: S3Provider) -> None:
        result = await provider.get_object("test-bucket", "nope")
        assert result is None

    async def test_delete(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "temp.txt"
        await provider.put_object(bucket, key, b"temp")

        # Act
        await provider.delete_object(bucket, key)

        # Assert
        assert await provider.get_object(bucket, key) is None

    async def test_list_objects(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        expected_keys = ["a.txt", "b.txt"]
        await provider.put_object(bucket, "a.txt", b"a")
        await provider.put_object(bucket, "b.txt", b"b")

        # Act
        actual_keys = await provider.list_objects(bucket)

        # Assert
        assert sorted(actual_keys) == expected_keys

    async def test_list_objects_with_prefix(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        expected_keys = ["logs/one.log", "logs/two.log"]
        await provider.put_object(bucket, "logs/one.log", b"1")
        await provider.put_object(bucket, "logs/two.log", b"2")
        await provider.put_object(bucket, "data/file.txt", b"3")

        # Act
        actual_keys = await provider.list_objects(bucket, prefix="logs/")

        # Assert
        assert sorted(actual_keys) == expected_keys

    async def test_put_with_content_type(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "data.json"
        expected_content_type = "application/json"

        # Act
        await provider.put_object(bucket, key, b"{}", content_type=expected_content_type)
        actual_obj = await provider.storage.get_object(bucket, key)

        # Assert
        assert actual_obj is not None
        assert actual_obj["content_type"] == expected_content_type
