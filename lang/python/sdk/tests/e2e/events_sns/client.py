"""Test client for events_sns tests."""

from __future__ import annotations

from .constants import EVENT_PATTERN, TEST_BUS, TEST_RULE, TEST_TOPIC, _topic_arn


class EventsSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _events = lws_session.client("events")
        self._events = _events
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass

    def create_topic(self, name=TEST_TOPIC):
        try:
            resp = self._sns.create_topic(Name=name)
            return resp["TopicArn"]
        except Exception:
            return _topic_arn(name)

    def create_rule_targeting_sns(self, bus=TEST_BUS, rule=TEST_RULE):
        self.create_bus(name=bus)
        self.create_topic()
        try:
            self._events.put_rule(
                Name=rule, EventBusName=bus, EventPattern=EVENT_PATTERN, State="ENABLED"
            )
        except Exception:
            pass
        try:
            self._events.put_targets(
                Rule=rule, EventBusName=bus, Targets=[{"Id": "t1", "Arn": _topic_arn()}]
            )
        except Exception:
            pass
