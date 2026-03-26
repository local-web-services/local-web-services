"""Test client for ssm_events tests."""

from __future__ import annotations

from .constants import TEST_BUS, TEST_PARAM, TEST_VALUE


class SsmEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _ssm = lws_session.client("ssm")
        self._ssm = _ssm
        _events = lws_session.client("events")
        self._events = _events

    def create_param(self, name=TEST_PARAM):
        self._ssm.put_parameter(Name=name, Value=TEST_VALUE, Type="String")

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)
