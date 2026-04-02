"""Test client for CloudTrail E2E tests."""

from __future__ import annotations

from .constants import (
    TEST_BUCKET,
    TEST_BUCKET_2,
    TEST_EB_BUS_ARN,
    TEST_TRAIL,
    TEST_TRAIL_2,
)


class CloudtrailTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("cloudtrail")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_trail(self, name=TEST_TRAIL, bucket=TEST_BUCKET):
        try:
            return self._client.create_trail(Name=name, S3BucketName=bucket)
        except Exception:
            pass

    def start_logging(self, name=TEST_TRAIL):
        try:
            self._client.start_logging(Name=name)
        except Exception:
            pass

    def stop_logging(self, name=TEST_TRAIL):
        try:
            self._client.stop_logging(Name=name)
        except Exception:
            pass

    def delete_trail(self, name=TEST_TRAIL):
        try:
            self._client.delete_trail(Name=name)
        except Exception:
            pass

    def create_trail_with_bus(self, name=TEST_TRAIL, bucket=TEST_BUCKET, bus_arn=TEST_EB_BUS_ARN):
        try:
            resp = self._client.create_trail(Name=name, S3BucketName=bucket)
            self._client.update_trail(Name=name, CloudWatchLogsLogGroupArn=bus_arn)
            return resp
        except Exception:
            pass

    def create_two_trails(self):
        self.create_trail(name=TEST_TRAIL, bucket=TEST_BUCKET)
        self.create_trail(name=TEST_TRAIL_2, bucket=TEST_BUCKET_2)
