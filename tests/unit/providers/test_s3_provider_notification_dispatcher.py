"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

import asyncio
from pathlib import Path

import pytest

from lws.providers.s3.notifications import NotificationDispatcher
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


class TestNotificationDispatcher:
    """Notification dispatch with filters."""

    async def test_dispatch_calls_handler(self) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "mybucket"
        expected_key = "test-key"

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register(bucket, "ObjectCreated:*", handler)

        # Act
        dispatcher.dispatch(bucket, "ObjectCreated:Put", expected_key)
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count
        actual_key = received[0]["s3"]["object"]["key"]
        assert actual_key == expected_key

    async def test_dispatch_prefix_filter(self) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "mybucket"
        expected_key = "images/photo.jpg"

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register(bucket, "ObjectCreated:*", handler, prefix_filter="images/")

        # Act
        dispatcher.dispatch(bucket, "ObjectCreated:Put", expected_key)
        dispatcher.dispatch(bucket, "ObjectCreated:Put", "docs/readme.md")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count
        actual_key = received[0]["s3"]["object"]["key"]
        assert actual_key == expected_key

    async def test_dispatch_suffix_filter(self) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "mybucket"

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register(bucket, "ObjectCreated:*", handler, suffix_filter=".jpg")

        # Act
        dispatcher.dispatch(bucket, "ObjectCreated:Put", "photo.jpg")
        dispatcher.dispatch(bucket, "ObjectCreated:Put", "photo.png")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count

    async def test_dispatch_wrong_bucket_ignored(self) -> None:
        # Arrange
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:*", handler)

        # Act
        dispatcher.dispatch("otherbucket", "ObjectCreated:Put", "key")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 0
        assert len(received) == expected_count

    async def test_dispatch_wrong_event_type_ignored(self) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "mybucket"

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register(bucket, "ObjectRemoved:*", handler)

        # Act
        dispatcher.dispatch(bucket, "ObjectCreated:Put", "key")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 0
        assert len(received) == expected_count

    async def test_dispatch_exact_event_match(self) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "mybucket"
        event_type = "ObjectCreated:Put"

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register(bucket, event_type, handler)

        # Act
        dispatcher.dispatch(bucket, event_type, "key")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count

    async def test_provider_notification_on_put(self, provider: S3Provider) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "test-bucket"
        expected_key = "notify-test"

        async def handler(record: dict) -> None:
            received.append(record)

        provider.register_notification_handler(bucket, handler)

        # Act
        await provider.put_object(bucket, expected_key, b"data")
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count
        actual_key = received[0]["s3"]["object"]["key"]
        assert actual_key == expected_key

    async def test_provider_notification_on_delete(self, provider: S3Provider) -> None:
        # Arrange
        received: list[dict] = []
        bucket = "test-bucket"
        key = "to-delete"

        async def handler(record: dict) -> None:
            received.append(record)

        provider.register_notification_handler(bucket, handler, event_type="ObjectRemoved:*")
        await provider.put_object(bucket, key, b"data")

        # Act
        await provider.delete_object(bucket, key)
        await asyncio.sleep(0.05)

        # Assert
        expected_count = 1
        assert len(received) == expected_count
