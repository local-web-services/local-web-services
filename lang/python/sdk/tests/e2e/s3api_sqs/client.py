"""Test client for s3api_sqs tests."""

from __future__ import annotations

from .constants import TEST_BUCKET, TEST_QUEUE


class S3apiSqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _s3 = lws_session.client("s3")
        self._s3 = _s3
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._s3.create_bucket(Bucket=name)
        except Exception:
            pass

    def create_queue(self, name=TEST_QUEUE):
        try:
            self._sqs.create_queue(QueueName=name)
        except Exception:
            pass
