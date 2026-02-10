"""S3Provider -- filesystem-backed implementation of IObjectStore."""

from __future__ import annotations

import shutil
import time
from collections.abc import Callable
from pathlib import Path

from lws.interfaces.object_store import IObjectStore
from lws.providers.s3.notifications import NotificationDispatcher
from lws.providers.s3.storage import LocalBucketStorage


class S3Provider(IObjectStore):
    """Local S3 provider backed by the filesystem.

    Each bucket is a directory under ``<data_dir>/s3/<bucket>``.
    """

    def __init__(self, data_dir: Path, buckets: list[str] | None = None) -> None:
        self._data_dir = data_dir
        self._buckets = list(buckets or [])
        self._storage = LocalBucketStorage(data_dir)
        self._dispatcher = NotificationDispatcher()
        self._started = False
        self._bucket_created: dict[str, float] = {}

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return "s3"

    async def start(self) -> None:
        """Create bucket directories and mark the provider as started."""
        now = time.time()
        for bucket in self._buckets:
            bucket_dir = self._data_dir / "s3" / bucket
            bucket_dir.mkdir(parents=True, exist_ok=True)
            self._bucket_created.setdefault(bucket, now)
        self._started = True

    async def stop(self) -> None:
        """No-op for filesystem storage."""
        self._started = False

    async def health_check(self) -> bool:
        return self._started

    # -- IObjectStore implementation ------------------------------------------

    async def put_object(
        self,
        bucket_name: str,
        key: str,
        body: bytes,
        content_type: str | None = None,
    ) -> None:
        await self._storage.put_object(bucket_name, key, body, content_type=content_type)
        self._dispatcher.dispatch(bucket_name, "ObjectCreated:Put", key)

    async def get_object(self, bucket_name: str, key: str) -> bytes | None:
        result = await self._storage.get_object(bucket_name, key)
        if result is None:
            return None
        return result["body"]

    async def delete_object(self, bucket_name: str, key: str) -> None:
        existed = await self._storage.delete_object(bucket_name, key)
        if existed:
            self._dispatcher.dispatch(bucket_name, "ObjectRemoved:Delete", key)

    async def list_objects(self, bucket_name: str, prefix: str = "") -> list[str]:
        result = await self._storage.list_objects(bucket_name, prefix=prefix)
        return [item["key"] for item in result["contents"]]

    # -- Bucket management ----------------------------------------------------

    async def create_bucket(self, bucket_name: str) -> None:
        """Create a bucket. Raises ValueError if it already exists."""
        if bucket_name in self._buckets:
            raise ValueError(f"Bucket already exists: {bucket_name}")
        bucket_dir = self._data_dir / "s3" / bucket_name
        bucket_dir.mkdir(parents=True, exist_ok=True)
        self._buckets.append(bucket_name)
        self._bucket_created[bucket_name] = time.time()

    async def delete_bucket(self, bucket_name: str) -> None:
        """Delete a bucket. Raises KeyError if not found."""
        if bucket_name not in self._buckets:
            raise KeyError(f"Bucket not found: {bucket_name}")
        bucket_dir = self._data_dir / "s3" / bucket_name
        if bucket_dir.exists():
            shutil.rmtree(bucket_dir)
        self._buckets.remove(bucket_name)
        self._bucket_created.pop(bucket_name, None)

    async def head_bucket(self, bucket_name: str) -> dict:
        """Return bucket metadata. Raises KeyError if not found."""
        if bucket_name not in self._buckets:
            raise KeyError(f"Bucket not found: {bucket_name}")
        created = self._bucket_created.get(bucket_name, time.time())
        return {
            "BucketName": bucket_name,
            "CreationDate": time.strftime("%Y-%m-%dT%H:%M:%S.000Z", time.gmtime(created)),
        }

    async def list_buckets(self) -> list[str]:
        """Return sorted list of bucket names."""
        return sorted(self._buckets)

    # -- Extended storage access (used by routes) -----------------------------

    @property
    def storage(self) -> LocalBucketStorage:
        """Expose underlying storage for route handlers that need full metadata."""
        return self._storage

    # -- Notification support -------------------------------------------------

    def register_notification_handler(
        self,
        bucket: str,
        handler: Callable,
        event_type: str = "ObjectCreated:*",
        prefix_filter: str = "",
        suffix_filter: str = "",
    ) -> None:
        """Register a notification handler for S3 events on a bucket."""
        self._dispatcher.register(
            bucket=bucket,
            event_type=event_type,
            handler=handler,
            prefix_filter=prefix_filter,
            suffix_filter=suffix_filter,
        )
