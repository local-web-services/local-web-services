"""Test client for events_sqs tests."""

from __future__ import annotations

from .constants import EVENT_PATTERN, TEST_BUS, TEST_QUEUE, TEST_RULE, _queue_arn


class EventsSqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _events = lws_session.client("events")
        self._events = _events
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass

    def create_queue(self, name=TEST_QUEUE):
        try:
            self._sqs.create_queue(QueueName=name)
        except Exception:
            pass

    def create_rule_targeting_sqs(self, bus=TEST_BUS, rule=TEST_RULE):
        self.create_bus(name=bus)
        try:
            self._events.put_rule(
                Name=rule, EventBusName=bus, EventPattern=EVENT_PATTERN, State="ENABLED"
            )
        except Exception:
            pass
        try:
            self._events.put_targets(
                Rule=rule, EventBusName=bus, Targets=[{"Id": "t1", "Arn": _queue_arn()}]
            )
        except Exception:
            pass
