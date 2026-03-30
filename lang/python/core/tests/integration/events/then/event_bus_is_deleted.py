"""Then: the event bus is "DELETED"."""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS


@then('the event bus is "DELETED"')
def event_bus_is_deleted_then(client: TestClient):
    r = client.post("/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"}, json={})
    actual_names = [b["Name"] for b in r.json().get("EventBuses", [])]
    assert (
        INT_BUS not in actual_names
    ), f"Expected event bus '{INT_BUS}' to be deleted but found in: {actual_names}"
