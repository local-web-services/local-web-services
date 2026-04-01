"""Test client for s3api_events tests."""

from __future__ import annotations

from .constants import TEST_BUCKET, TEST_BUS


class S3apiEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _s3 = lws_session.client("s3")
        self._s3 = _s3
        _events = lws_session.client("events")
        self._events = _events

    def create_bucket(self, name=TEST_BUCKET):
        try:
            self._s3.create_bucket(Bucket=name)
        except Exception:
            pass

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass
