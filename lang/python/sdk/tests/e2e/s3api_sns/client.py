"""Test client for s3api_sns tests."""

from __future__ import annotations

from .constants import TEST_BUCKET, TEST_TOPIC


class S3apiSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _s3 = lws_session.client("s3")
        self._s3 = _s3
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._s3.create_bucket(Bucket=name)
        except Exception:
            pass

    def create_topic(self, name=TEST_TOPIC):
        try:
            self._sns.create_topic(Name=name)
        except Exception:
            pass
