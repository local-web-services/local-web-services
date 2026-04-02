"""Test client for s3tables tests."""

from __future__ import annotations

from .constants import TEST_BUCKET, TEST_NAMESPACE, TEST_TABLE


class S3tablesTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("s3tables")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_bucket(self, bucket_name=TEST_BUCKET):
        return self._client.create_table_bucket(name=bucket_name)

    def get_bucket_arn(self, bucket_name=TEST_BUCKET):
        resp = self._client.get_table_bucket(tableBucketARN=bucket_name)
        return resp.get("arn", bucket_name)

    def create_namespace(self, bucket_arn=None, namespace=TEST_NAMESPACE):
        if bucket_arn is None:
            bucket_arn = self.get_bucket_arn()
        self._client.create_namespace(tableBucketARN=bucket_arn, namespace=[namespace])

    def create_table(self, bucket_arn=None, namespace=TEST_NAMESPACE, table_name=TEST_TABLE):
        if bucket_arn is None:
            bucket_arn = self.get_bucket_arn()
        self._client.create_table(
            tableBucketARN=bucket_arn,
            namespace=namespace,
            name=table_name,
            format="ICEBERG",
        )

    def setup_bucket_and_namespace(self):
        try:
            resp = self.create_bucket()
            bucket_arn = resp.get("arn", TEST_BUCKET)
        except Exception:
            bucket_arn = self.get_bucket_arn()
        try:
            self.create_namespace(bucket_arn=bucket_arn)
        except Exception:
            pass
        return bucket_arn

    def setup_bucket_namespace_table(self):
        bucket_arn = self.setup_bucket_and_namespace()
        try:
            self.create_table(bucket_arn=bucket_arn)
        except Exception:
            pass
        return bucket_arn
