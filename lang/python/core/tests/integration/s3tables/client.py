"""Test client for s3tables tests."""

from __future__ import annotations

from .constants import INT_BUCKET, INT_NAMESPACE, INT_TABLE


class S3tablesTestClient:
    def __init__(self, client):
        self._client = client

    def create_bucket(self, name: str = INT_BUCKET) -> None:
        self._client.put("/buckets", json={"name": name})

    def create_namespace(self, bucket: str = INT_BUCKET, namespace: str = INT_NAMESPACE) -> None:
        self._client.put(f"/namespaces/{bucket}", json={"namespace": [namespace]})

    def create_table(
        self,
        bucket: str = INT_BUCKET,
        namespace: str = INT_NAMESPACE,
        table: str = INT_TABLE,
    ) -> None:
        self._client.put(f"/tables/{bucket}/{namespace}", json={"name": table, "format": "ICEBERG"})
