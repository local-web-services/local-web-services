"""S3 helper for seeding and asserting bucket state."""

from __future__ import annotations

from typing import Any


class S3Helper:
    """Convenience wrapper for a single S3 bucket.

    Usage::

        bucket = session.s3("ReceiptsBucket")
        bucket.put("receipts/2024/001.pdf", b"PDF bytes here")
        content = bucket.get("receipts/2024/001.pdf")
    """

    def __init__(self, bucket_name: str, client: Any) -> None:
        self._bucket_name = bucket_name
        self._client = client

    def put(self, key: str, body: bytes | str, **kwargs: Any) -> None:
        """Upload *body* to *key* in the bucket."""
        if isinstance(body, str):
            body = body.encode()
        self._client.put_object(Bucket=self._bucket_name, Key=key, Body=body, **kwargs)

    def get(self, key: str) -> bytes:
        """Return the raw bytes stored at *key*."""
        response = self._client.get_object(Bucket=self._bucket_name, Key=key)
        return response["Body"].read()

    def get_text(self, key: str, encoding: str = "utf-8") -> str:
        """Return the content at *key* decoded as a string."""
        return self.get(key).decode(encoding)

    def delete(self, key: str) -> None:
        """Delete the object at *key*."""
        self._client.delete_object(Bucket=self._bucket_name, Key=key)

    def list_keys(self, prefix: str = "") -> list[str]:
        """Return all object keys in the bucket (optionally filtered by prefix)."""
        keys: list[str] = []
        paginator = self._client.get_paginator("list_objects_v2")
        kwargs: dict[str, Any] = {"Bucket": self._bucket_name}
        if prefix:
            kwargs["Prefix"] = prefix
        for page in paginator.paginate(**kwargs):
            for obj in page.get("Contents", []):
                keys.append(obj["Key"])
        return keys

    def assert_object_exists(self, key: str) -> None:
        """Assert that *key* exists in the bucket."""
        keys = self.list_keys()
        assert key in keys, (
            f"Expected object {key!r} to exist in bucket {self._bucket_name!r}, "
            f"but it was not found. Existing keys: {keys}"
        )

    def assert_object_count(self, expected_count: int, prefix: str = "") -> None:
        """Assert the number of objects in the bucket (optionally filtered by prefix)."""
        actual_keys = self.list_keys(prefix=prefix)
        actual_count = len(actual_keys)
        assert actual_count == expected_count, (
            f"Expected {expected_count} object(s) in bucket {self._bucket_name!r}"
            + (f" with prefix {prefix!r}" if prefix else "")
            + f", but found {actual_count}."
        )
