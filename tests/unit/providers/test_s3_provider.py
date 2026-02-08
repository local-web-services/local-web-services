"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

import asyncio
import hashlib
from pathlib import Path

import pytest

from ldk.providers.s3.notifications import NotificationDispatcher
from ldk.providers.s3.presigned import generate_presigned_url, validate_presigned_url
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


class TestLocalBucketStoragePutGet:
    """put_object / get_object round-trip tests."""

    async def test_put_and_get_round_trip(self, storage: LocalBucketStorage) -> None:
        body = b"hello world"
        result = await storage.put_object("mybucket", "greeting.txt", body)

        assert "ETag" in result
        expected_etag = hashlib.md5(body).hexdigest()
        assert result["ETag"] == f'"{expected_etag}"'

        obj = await storage.get_object("mybucket", "greeting.txt")
        assert obj is not None
        assert obj["body"] == body
        assert obj["content_type"] == "application/octet-stream"
        assert obj["size"] == len(body)
        assert obj["etag"] == expected_etag

    async def test_put_with_content_type(self, storage: LocalBucketStorage) -> None:
        await storage.put_object(
            "mybucket", "data.json", b'{"a":1}', content_type="application/json"
        )
        obj = await storage.get_object("mybucket", "data.json")
        assert obj is not None
        assert obj["content_type"] == "application/json"

    async def test_put_with_metadata(self, storage: LocalBucketStorage) -> None:
        await storage.put_object(
            "mybucket",
            "tagged.txt",
            b"data",
            metadata={"x-amz-meta-author": "test"},
        )
        obj = await storage.get_object("mybucket", "tagged.txt")
        assert obj is not None
        assert obj["metadata"] == {"x-amz-meta-author": "test"}

    async def test_get_nonexistent_returns_none(self, storage: LocalBucketStorage) -> None:
        result = await storage.get_object("nobucket", "nokey")
        assert result is None

    async def test_put_overwrites_existing(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "key", b"version1")
        await storage.put_object("mybucket", "key", b"version2")
        obj = await storage.get_object("mybucket", "key")
        assert obj is not None
        assert obj["body"] == b"version2"

    async def test_nested_key(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "a/b/c/deep.txt", b"deep")
        obj = await storage.get_object("mybucket", "a/b/c/deep.txt")
        assert obj is not None
        assert obj["body"] == b"deep"


class TestLocalBucketStorageDelete:
    """delete_object tests."""

    async def test_delete_existing(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "key", b"data")
        existed = await storage.delete_object("mybucket", "key")
        assert existed is True
        assert await storage.get_object("mybucket", "key") is None

    async def test_delete_nonexistent(self, storage: LocalBucketStorage) -> None:
        existed = await storage.delete_object("mybucket", "nokey")
        assert existed is False

    async def test_delete_removes_metadata(self, storage: LocalBucketStorage, tmp_path: Path):
        await storage.put_object("mybucket", "key", b"data")
        meta_path = tmp_path / "s3" / ".metadata" / "mybucket" / "key.json"
        assert meta_path.exists()
        await storage.delete_object("mybucket", "key")
        assert not meta_path.exists()


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


class TestLocalBucketStorageList:
    """list_objects tests."""

    async def test_list_empty_bucket(self, storage: LocalBucketStorage) -> None:
        result = await storage.list_objects("emptybucket")
        assert result["contents"] == []
        assert result["is_truncated"] is False

    async def test_list_all_objects(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "a.txt", b"a")
        await storage.put_object("mybucket", "b.txt", b"b")
        await storage.put_object("mybucket", "c.txt", b"c")

        result = await storage.list_objects("mybucket")
        keys = [item["key"] for item in result["contents"]]
        assert sorted(keys) == ["a.txt", "b.txt", "c.txt"]

    async def test_list_with_prefix(self, storage: LocalBucketStorage) -> None:
        await storage.put_object("mybucket", "logs/2024/jan.log", b"1")
        await storage.put_object("mybucket", "logs/2024/feb.log", b"2")
        await storage.put_object("mybucket", "data/file.txt", b"3")

        result = await storage.list_objects("mybucket", prefix="logs/")
        keys = [item["key"] for item in result["contents"]]
        assert len(keys) == 2
        assert all(k.startswith("logs/") for k in keys)

    async def test_list_pagination(self, storage: LocalBucketStorage) -> None:
        for i in range(5):
            await storage.put_object("mybucket", f"key-{i:03d}", b"x")

        # First page
        page1 = await storage.list_objects("mybucket", max_keys=2)
        assert len(page1["contents"]) == 2
        assert page1["is_truncated"] is True
        assert page1["next_token"] is not None

        # Second page
        page2 = await storage.list_objects(
            "mybucket", max_keys=2, continuation_token=page1["next_token"]
        )
        assert len(page2["contents"]) == 2
        assert page2["is_truncated"] is True

        # Third page
        page3 = await storage.list_objects(
            "mybucket", max_keys=2, continuation_token=page2["next_token"]
        )
        assert len(page3["contents"]) == 1
        assert page3["is_truncated"] is False

        # All keys collected
        all_keys = [item["key"] for page in [page1, page2, page3] for item in page["contents"]]
        assert len(all_keys) == 5


class TestETagComputation:
    """Verify ETag is computed as MD5 hex digest."""

    async def test_etag_matches_md5(self, storage: LocalBucketStorage) -> None:
        body = b"specific content for etag test"
        expected = hashlib.md5(body).hexdigest()

        result = await storage.put_object("mybucket", "etag-test", body)
        assert result["ETag"] == f'"{expected}"'

        obj = await storage.get_object("mybucket", "etag-test")
        assert obj is not None
        assert obj["etag"] == expected

    async def test_different_content_different_etag(self, storage: LocalBucketStorage) -> None:
        r1 = await storage.put_object("mybucket", "k1", b"aaa")
        r2 = await storage.put_object("mybucket", "k2", b"bbb")
        assert r1["ETag"] != r2["ETag"]


# ---------------------------------------------------------------------------
# P1-14: S3Provider lifecycle and IObjectStore
# ---------------------------------------------------------------------------


class TestS3ProviderLifecycle:
    """Provider lifecycle tests."""

    async def test_name(self, provider: S3Provider) -> None:
        assert provider.name == "s3"

    async def test_health_check_running(self, provider: S3Provider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["bucket"])
        assert await p.health_check() is False

    async def test_start_creates_bucket_dirs(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["alpha", "beta"])
        await p.start()
        assert (tmp_path / "s3" / "alpha").is_dir()
        assert (tmp_path / "s3" / "beta").is_dir()
        await p.stop()

    async def test_stop_marks_unhealthy(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["bucket"])
        await p.start()
        assert await p.health_check() is True
        await p.stop()
        assert await p.health_check() is False


class TestS3ProviderCRUD:
    """IObjectStore CRUD via S3Provider."""

    async def test_put_and_get(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "hello.txt", b"hello")
        result = await provider.get_object("test-bucket", "hello.txt")
        assert result == b"hello"

    async def test_get_nonexistent(self, provider: S3Provider) -> None:
        result = await provider.get_object("test-bucket", "nope")
        assert result is None

    async def test_delete(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "temp.txt", b"temp")
        await provider.delete_object("test-bucket", "temp.txt")
        assert await provider.get_object("test-bucket", "temp.txt") is None

    async def test_list_objects(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "a.txt", b"a")
        await provider.put_object("test-bucket", "b.txt", b"b")
        keys = await provider.list_objects("test-bucket")
        assert sorted(keys) == ["a.txt", "b.txt"]

    async def test_list_objects_with_prefix(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "logs/one.log", b"1")
        await provider.put_object("test-bucket", "logs/two.log", b"2")
        await provider.put_object("test-bucket", "data/file.txt", b"3")
        keys = await provider.list_objects("test-bucket", prefix="logs/")
        assert sorted(keys) == ["logs/one.log", "logs/two.log"]

    async def test_put_with_content_type(self, provider: S3Provider) -> None:
        await provider.put_object(
            "test-bucket", "data.json", b"{}", content_type="application/json"
        )
        # Verify via storage
        obj = await provider.storage.get_object("test-bucket", "data.json")
        assert obj is not None
        assert obj["content_type"] == "application/json"


class TestMetadataStorage:
    """Metadata sidecar persistence."""

    async def test_metadata_persists(self, provider: S3Provider) -> None:
        await provider.put_object("test-bucket", "key", b"val")
        meta = await provider.storage.head_object("test-bucket", "key")
        assert meta is not None
        assert meta["size"] == 3
        assert meta["etag"] == hashlib.md5(b"val").hexdigest()
        assert meta["content_type"] == "application/octet-stream"
        assert meta["last_modified"] != ""


# ---------------------------------------------------------------------------
# P1-15: NotificationDispatcher
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


# ---------------------------------------------------------------------------
# P1-16: Presigned URLs
# ---------------------------------------------------------------------------


class TestPresignedUrls:
    """Presigned URL generation and validation."""

    def test_generate_returns_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey")
        assert "mybucket" in url
        assert "mykey" in url
        assert "X-Amz-Signature" in url

    def test_validate_valid_url(self) -> None:
        key = "test-signing-key"
        url = generate_presigned_url("mybucket", "mykey", signing_key=key)
        assert validate_presigned_url(url, signing_key=key) is True

    def test_validate_wrong_key_fails(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", signing_key="correct-key")
        assert validate_presigned_url(url, signing_key="wrong-key") is False

    def test_validate_expired_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", expires_in=-1, signing_key="key")
        assert validate_presigned_url(url, signing_key="key") is False

    def test_validate_tampered_url(self) -> None:
        key = "signing-key"
        url = generate_presigned_url("mybucket", "mykey", signing_key=key)
        # Tamper with the signature
        tampered = url.replace("X-Amz-Signature=", "X-Amz-Signature=bad")
        assert validate_presigned_url(tampered, signing_key=key) is False

    def test_default_signing_key(self) -> None:
        """Using default key for both generate and validate should work."""
        url = generate_presigned_url("mybucket", "mykey")
        assert validate_presigned_url(url) is True

    def test_put_method(self) -> None:
        key = "test-key"
        url = generate_presigned_url("mybucket", "mykey", method="PUT", signing_key=key)
        assert "X-Amz-Method=PUT" in url
        assert validate_presigned_url(url, signing_key=key) is True

    def test_custom_base_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", base_url="http://localhost:9000")
        assert url.startswith("http://localhost:9000/")
