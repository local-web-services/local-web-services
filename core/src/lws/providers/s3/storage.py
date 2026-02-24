"""Filesystem-backed object storage for local S3 emulation."""

from __future__ import annotations

import asyncio
import hashlib
import json
from datetime import UTC, datetime
from pathlib import Path


class LocalBucketStorage:
    """Low-level filesystem storage for S3 objects.

    Objects are stored at ``<data_dir>/s3/<bucket>/<key>``.
    Metadata sidecars live at ``<data_dir>/s3/.metadata/<bucket>/<key>.json``.
    """

    def __init__(self, data_dir: Path) -> None:
        self._data_dir = data_dir

    # ------------------------------------------------------------------
    # Path helpers
    # ------------------------------------------------------------------

    def _object_path(self, bucket: str, key: str) -> Path:
        return self._data_dir / "s3" / bucket / key

    def _metadata_path(self, bucket: str, key: str) -> Path:
        return self._data_dir / "s3" / ".metadata" / bucket / (key + ".json")

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    async def put_object(
        self,
        bucket: str,
        key: str,
        body: bytes,
        content_type: str | None = None,
        metadata: dict | None = None,
    ) -> dict:
        """Store an object and its metadata sidecar. Returns dict with ETag."""
        etag = hashlib.md5(body).hexdigest()  # noqa: S324
        now = datetime.now(UTC).isoformat()

        obj_path = self._object_path(bucket, key)
        meta_path = self._metadata_path(bucket, key)

        meta_doc = {
            "content_type": content_type or "application/octet-stream",
            "etag": etag,
            "size": len(body),
            "last_modified": now,
            "metadata": metadata or {},
        }

        await asyncio.to_thread(self._write_object, obj_path, body)
        await asyncio.to_thread(self._write_metadata, meta_path, meta_doc)

        return {"ETag": f'"{etag}"'}

    async def get_object(self, bucket: str, key: str) -> dict | None:
        """Retrieve an object and its metadata. Returns None if not found."""
        obj_path = self._object_path(bucket, key)
        meta_path = self._metadata_path(bucket, key)

        if not await asyncio.to_thread(obj_path.exists):
            return None

        body = await asyncio.to_thread(self._read_object, obj_path)
        meta = await asyncio.to_thread(self._read_metadata, meta_path)

        return {
            "body": body,
            "content_type": meta.get("content_type", "application/octet-stream"),
            "etag": meta.get("etag", ""),
            "size": meta.get("size", len(body)),
            "last_modified": meta.get("last_modified", ""),
            "metadata": meta.get("metadata", {}),
        }

    async def delete_object(self, bucket: str, key: str) -> bool:
        """Delete an object and its metadata sidecar. Returns True if it existed."""
        obj_path = self._object_path(bucket, key)
        meta_path = self._metadata_path(bucket, key)

        existed = await asyncio.to_thread(obj_path.exists)
        if existed:
            await asyncio.to_thread(obj_path.unlink)
        if await asyncio.to_thread(meta_path.exists):
            await asyncio.to_thread(meta_path.unlink)

        return existed

    async def head_object(self, bucket: str, key: str) -> dict | None:
        """Return metadata for an object without retrieving the body."""
        obj_path = self._object_path(bucket, key)
        meta_path = self._metadata_path(bucket, key)

        if not await asyncio.to_thread(obj_path.exists):
            return None

        meta = await asyncio.to_thread(self._read_metadata, meta_path)
        return {
            "content_type": meta.get("content_type", "application/octet-stream"),
            "etag": meta.get("etag", ""),
            "size": meta.get("size", 0),
            "last_modified": meta.get("last_modified", ""),
            "metadata": meta.get("metadata", {}),
        }

    async def list_objects(
        self,
        bucket: str,
        prefix: str = "",
        max_keys: int = 1000,
        continuation_token: str | None = None,
    ) -> dict:
        """List objects in *bucket* matching *prefix* with pagination support."""
        bucket_dir = self._data_dir / "s3" / bucket

        all_keys = await asyncio.to_thread(self._collect_keys, bucket_dir, prefix)
        all_keys.sort()

        # Apply continuation token (alphabetical ordering)
        if continuation_token:
            start_idx = 0
            for i, k in enumerate(all_keys):
                if k > continuation_token:
                    start_idx = i
                    break
            else:
                # All keys are <= token, nothing left
                return {"contents": [], "is_truncated": False, "next_token": None}
            all_keys = all_keys[start_idx:]

        is_truncated = len(all_keys) > max_keys
        page_keys = all_keys[:max_keys]
        next_token = page_keys[-1] if is_truncated else None

        contents: list[dict] = []
        for key in page_keys:
            meta = await self.head_object(bucket, key)
            contents.append(
                {
                    "key": key,
                    "size": meta["size"] if meta else 0,
                    "etag": meta["etag"] if meta else "",
                    "last_modified": meta["last_modified"] if meta else "",
                }
            )

        return {
            "contents": contents,
            "is_truncated": is_truncated,
            "next_token": next_token,
        }

    # ------------------------------------------------------------------
    # Synchronous filesystem helpers (run via asyncio.to_thread)
    # ------------------------------------------------------------------

    @staticmethod
    def _write_object(path: Path, data: bytes) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(data)

    @staticmethod
    def _write_metadata(path: Path, meta: dict) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(meta), encoding="utf-8")

    @staticmethod
    def _read_object(path: Path) -> bytes:
        return path.read_bytes()

    @staticmethod
    def _read_metadata(path: Path) -> dict:
        if not path.exists():
            return {}
        return json.loads(path.read_text(encoding="utf-8"))

    @staticmethod
    def _collect_keys(bucket_dir: Path, prefix: str) -> list[str]:
        """Walk *bucket_dir* and return all keys matching *prefix*."""
        if not bucket_dir.exists():
            return []
        keys: list[str] = []
        for file_path in bucket_dir.rglob("*"):
            if file_path.is_file():
                relative = file_path.relative_to(bucket_dir).as_posix()
                if relative.startswith(prefix):
                    keys.append(relative)
        return keys
