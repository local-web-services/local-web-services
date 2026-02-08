"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

import asyncio
from pathlib import Path

import pytest

from ldk.providers.s3.notifications import NotificationDispatcher
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


class TestNotificationDispatcher:
    """Notification dispatch with filters."""

    async def test_dispatch_calls_handler(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:*", handler)
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "test-key")

        # Allow the async task to run
        await asyncio.sleep(0.05)
        assert len(received) == 1
        assert received[0]["s3"]["object"]["key"] == "test-key"

    async def test_dispatch_prefix_filter(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:*", handler, prefix_filter="images/")
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "images/photo.jpg")
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "docs/readme.md")

        await asyncio.sleep(0.05)
        assert len(received) == 1
        assert received[0]["s3"]["object"]["key"] == "images/photo.jpg"

    async def test_dispatch_suffix_filter(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:*", handler, suffix_filter=".jpg")
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "photo.jpg")
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "photo.png")

        await asyncio.sleep(0.05)
        assert len(received) == 1

    async def test_dispatch_wrong_bucket_ignored(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:*", handler)
        dispatcher.dispatch("otherbucket", "ObjectCreated:Put", "key")

        await asyncio.sleep(0.05)
        assert len(received) == 0

    async def test_dispatch_wrong_event_type_ignored(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectRemoved:*", handler)
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "key")

        await asyncio.sleep(0.05)
        assert len(received) == 0

    async def test_dispatch_exact_event_match(self) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        dispatcher = NotificationDispatcher()
        dispatcher.register("mybucket", "ObjectCreated:Put", handler)
        dispatcher.dispatch("mybucket", "ObjectCreated:Put", "key")

        await asyncio.sleep(0.05)
        assert len(received) == 1

    async def test_provider_notification_on_put(self, provider: S3Provider) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        provider.register_notification_handler("test-bucket", handler)
        await provider.put_object("test-bucket", "notify-test", b"data")

        await asyncio.sleep(0.05)
        assert len(received) == 1
        assert received[0]["s3"]["object"]["key"] == "notify-test"

    async def test_provider_notification_on_delete(self, provider: S3Provider) -> None:
        received: list[dict] = []

        async def handler(record: dict) -> None:
            received.append(record)

        provider.register_notification_handler("test-bucket", handler, event_type="ObjectRemoved:*")
        await provider.put_object("test-bucket", "to-delete", b"data")
        await provider.delete_object("test-bucket", "to-delete")

        await asyncio.sleep(0.05)
        assert len(received) == 1
