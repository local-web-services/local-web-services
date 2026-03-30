"""Test client for lambda_events tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_BUS, TEST_FUNC


class LambdaEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _events = lws_session.client("events")
        self._events = _events

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)
