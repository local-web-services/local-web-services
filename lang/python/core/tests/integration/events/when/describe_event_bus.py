"""When: an event bus is described."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, _store


@when("an event bus is described")
def describe_event_bus(client: TestClient, world):
    r = client.post(
        "/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeEventBus"}, json={"Name": INT_BUS}
    )
    _store(world, r)
