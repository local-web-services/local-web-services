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


class TestLocalBucketStorageList:
    """list_objects tests."""

    async def test_list_empty_bucket(self, storage: LocalBucketStorage) -> None:
        result = await storage.list_objects("emptybucket")
        assert result["contents"] == []
        assert result["is_truncated"] is False

    async def test_list_all_objects(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        expected_keys = ["a.txt", "b.txt", "c.txt"]
        await storage.put_object(bucket, "a.txt", b"a")
        await storage.put_object(bucket, "b.txt", b"b")
        await storage.put_object(bucket, "c.txt", b"c")

        # Act
        result = await storage.list_objects(bucket)
        actual_keys = sorted([item["key"] for item in result["contents"]])

        # Assert
        assert actual_keys == expected_keys

    async def test_list_with_prefix(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        prefix = "logs/"
        expected_count = 2
        await storage.put_object(bucket, "logs/2024/jan.log", b"1")
        await storage.put_object(bucket, "logs/2024/feb.log", b"2")
        await storage.put_object(bucket, "data/file.txt", b"3")

        # Act
        result = await storage.list_objects(bucket, prefix=prefix)
        actual_keys = [item["key"] for item in result["contents"]]

        # Assert
        assert len(actual_keys) == expected_count
        assert all(k.startswith(prefix) for k in actual_keys)

    async def test_list_pagination(self, storage: LocalBucketStorage) -> None:
        # Arrange
        bucket = "mybucket"
        expected_total_keys = 5
        page_size = 2
        for i in range(expected_total_keys):
            await storage.put_object(bucket, f"key-{i:03d}", b"x")

        # Act / Assert - First page
        page1 = await storage.list_objects(bucket, max_keys=page_size)
        assert len(page1["contents"]) == page_size
        assert page1["is_truncated"] is True
        assert page1["next_token"] is not None

        # Act / Assert - Second page
        page2 = await storage.list_objects(
            bucket, max_keys=page_size, continuation_token=page1["next_token"]
        )
        assert len(page2["contents"]) == page_size
        assert page2["is_truncated"] is True

        # Act / Assert - Third page
        page3 = await storage.list_objects(
            bucket, max_keys=page_size, continuation_token=page2["next_token"]
        )
        assert len(page3["contents"]) == 1
        assert page3["is_truncated"] is False

        # Assert - All keys collected
        all_keys = [item["key"] for page in [page1, page2, page3] for item in page["contents"]]
        assert len(all_keys) == expected_total_keys
