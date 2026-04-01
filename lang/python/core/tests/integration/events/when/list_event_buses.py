"""When: all event buses are listed."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, _store


@when("all event buses are listed")
def list_event_buses(client: TestClient, world):
    r = client.post("/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"}, json={})
    _store(world, r)
