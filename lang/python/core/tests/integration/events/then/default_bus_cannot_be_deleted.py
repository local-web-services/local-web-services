"""Then: the default event bus cannot be deleted."""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET


@then("the default event bus cannot be deleted")
def default_bus_cannot_be_deleted(client: TestClient):
    r = client.post(
        "/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteEventBus"}, json={"Name": "default"}
    )
    actual_deleted = r.status_code == 200
    assert not actual_deleted, "Expected deleting the default event bus to fail"
