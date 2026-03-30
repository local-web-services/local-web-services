"""Test client for events_dynamodb tests."""

from __future__ import annotations

from .constants import EVENT_PATTERN, TEST_BUS, TEST_PK, TEST_RULE, TEST_TABLE


class EventsDynamodbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _events = lws_session.client("events")
        self._events = _events
        _dynamo = lws_session.client("dynamodb")
        self._dynamo = _dynamo

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass

    def create_rule(self, bus=TEST_BUS, rule=TEST_RULE):
        self.create_bus(name=bus)
        try:
            self._events.put_rule(
                Name=rule, EventBusName=bus, EventPattern=EVENT_PATTERN, State="ENABLED"
            )
        except Exception:
            pass

    def create_table(self, name=TEST_TABLE):
        try:
            self._dynamo.create_table(
                TableName=name,
                KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
                AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
                BillingMode="PAY_PER_REQUEST",
            )
        except Exception:
            pass
