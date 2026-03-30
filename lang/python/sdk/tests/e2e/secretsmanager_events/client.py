"""Test client for secretsmanager_events tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_BUS, TEST_SECRET, TEST_SECRET_VALUE


class SecretsmanagerEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sm = lws_session.client("secretsmanager")
        self._sm = _sm
        _events = lws_session.client("events")
        self._events = _events

    def create_secret(self, name=TEST_SECRET):
        try:
            self._sm.create_secret(Name=name, SecretString=TEST_SECRET_VALUE)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceExistsException":
                return
            raise

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass
