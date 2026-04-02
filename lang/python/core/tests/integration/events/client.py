"""Test client for events tests."""

from __future__ import annotations

from .constants import (
    _EVENTS_TARGET,
    EVENT_PATTERN,
    INT_BUS,
    INT_RULE,
    INT_TARGET_ARN,
    INT_TARGET_ID,
)


class EventsTestClient:
    def __init__(self, client):
        self._client = client

    def create_bus(self, name: str = INT_BUS) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EVENTS_TARGET}.CreateEventBus"},
            json={"Name": name},
        )

    def create_rule(self, bus_name: str = INT_BUS, rule_name: str = INT_RULE) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutRule"},
            json={
                "Name": rule_name,
                "EventBusName": bus_name,
                "EventPattern": EVENT_PATTERN,
                "State": "ENABLED",
            },
        )

    def put_target(self, bus_name: str = INT_BUS, rule_name: str = INT_RULE) -> None:
        self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutTargets"},
            json={
                "Rule": rule_name,
                "EventBusName": bus_name,
                "Targets": [{"Id": INT_TARGET_ID, "Arn": INT_TARGET_ARN}],
            },
        )
