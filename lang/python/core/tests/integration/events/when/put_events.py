"""When: events are published to an event bus."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, _store


@when("events are published to an event bus")
def put_events(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutEvents"},
        json={
            "Entries": [
                {
                    "EventBusName": INT_BUS,
                    "Source": "int.test.source",
                    "DetailType": "IntTestEvent",
                    "Detail": '{"key": "value"}',
                }
            ]
        },
    )
    _store(world, r)
