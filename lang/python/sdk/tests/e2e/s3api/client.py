"""Test client for s3api tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_BODY, TEST_BUCKET, TEST_KEY


class S3apiTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("s3")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._client.create_bucket(Bucket=name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] in ("BucketAlreadyOwnedByYou", "BucketAlreadyExists"):
                return
            raise

    def put_object(self, bucket=TEST_BUCKET, key=TEST_KEY):
        self.create_bucket(name=bucket)
        self._client.put_object(Bucket=bucket, Key=key, Body=TEST_BODY)

    def empty_and_delete_bucket(self, name=TEST_BUCKET):
        """Remove all objects from a bucket then delete it."""
        s3 = self._client
        try:
            paginator = s3.get_paginator("list_objects_v2")
            for page in paginator.paginate(Bucket=name):
                objects = [{"Key": obj["Key"]} for obj in page.get("Contents", [])]
                if objects:
                    s3.delete_objects(Bucket=name, Delete={"Objects": objects})
            s3.delete_bucket(Bucket=name)
        except Exception:
            pass
