"""Then: the event bus is "ACTIVE"."""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS


@then('the "eventbridge" "bus" will be "ACTIVE"')
def event_bus_is_active_then(client: TestClient):
    r = client.post("/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"}, json={})
    actual_names = [b["Name"] for b in r.json().get("EventBuses", [])]
    assert (
        INT_BUS in actual_names
    ), f"Expected event bus '{INT_BUS}' to exist but not found in: {actual_names}"
