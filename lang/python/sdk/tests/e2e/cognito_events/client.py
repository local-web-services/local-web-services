"""Test client for cognito_events tests."""

from __future__ import annotations

from .constants import TEST_BUS, TEST_POOL


class CognitoEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _cognito = lws_session.client("cognito-idp")
        self._cognito = _cognito
        _events = lws_session.client("events")
        self._events = _events

    def create_pool(self, name=TEST_POOL):
        try:
            self._cognito.create_user_pool(PoolName=name)
        except Exception:
            pass

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass
