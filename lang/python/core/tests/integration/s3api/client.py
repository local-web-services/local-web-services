"""Test client for s3api tests."""

from __future__ import annotations

from .constants import INT_BODY, INT_BUCKET, INT_KEY


class S3apiTestClient:
    def __init__(self, sync_client):
        self._client = sync_client

    def create_bucket(self, name: str = INT_BUCKET) -> None:
        self._client.put(f"/{name}")

    def put_object(self, bucket: str = INT_BUCKET, key: str = INT_KEY) -> None:
        self._client.put(f"/{bucket}/{key}", content=INT_BODY)
