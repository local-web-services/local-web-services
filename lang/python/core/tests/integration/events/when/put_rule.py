"""When: an EventBridge rule is created."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, EVENT_PATTERN, INT_BUS, INT_RULE, _store


@when("an EventBridge rule is created")
def put_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutRule"},
        json={
            "Name": INT_RULE,
            "EventBusName": INT_BUS,
            "EventPattern": EVENT_PATTERN,
            "State": "ENABLED",
        },
    )
    _store(world, r)
