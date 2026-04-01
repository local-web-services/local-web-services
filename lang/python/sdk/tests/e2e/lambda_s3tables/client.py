"""Test client for lambda_s3tables tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_BUCKET, TEST_FUNC, TEST_NAMESPACE, _table_bucket_arn


class LambdaS3tablesTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _s3tables = lws_session.client("s3tables")
        self._s3tables = _s3tables

    def create_function(self, name=TEST_FUNC):
        try:
            self._lambda.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except Exception:
            pass

    def create_table_bucket(self, name=TEST_BUCKET):
        try:
            self._s3tables.create_table_bucket(name=name)
        except Exception:
            pass

    def create_namespace(self, bucket_name=TEST_BUCKET, namespace=TEST_NAMESPACE):
        try:
            self._s3tables.create_namespace(
                tableBucketARN=_table_bucket_arn(bucket_name), namespace=[namespace]
            )
        except Exception:
            pass

    def table_bucket_exists(self, name=TEST_BUCKET):
        resp = self._s3tables.list_table_buckets()
        return any(b["name"] == name for b in resp.get("tableBuckets", []))
