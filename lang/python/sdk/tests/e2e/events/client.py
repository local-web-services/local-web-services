"""Test client for events tests."""

from __future__ import annotations

from .constants import EVENT_PATTERN, TEST_BUS, TEST_RULE, TEST_TARGET_ARN, TEST_TARGET_ID


class EventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("events")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_bus(self, name=TEST_BUS):
        try:
            self._client.create_event_bus(Name=name)
        except Exception:
            pass

    def create_rule(self, bus_name=TEST_BUS, rule_name=TEST_RULE):
        self.create_bus(name=bus_name)
        try:
            self._client.put_rule(
                Name=rule_name, EventBusName=bus_name, EventPattern=EVENT_PATTERN, State="ENABLED"
            )
        except Exception:
            pass

    def put_target(self, bus_name=TEST_BUS, rule_name=TEST_RULE):
        self.create_rule(bus_name=bus_name, rule_name=rule_name)
        try:
            self._client.put_targets(
                Rule=rule_name,
                EventBusName=bus_name,
                Targets=[{"Id": TEST_TARGET_ID, "Arn": TEST_TARGET_ARN}],
            )
        except Exception:
            pass
