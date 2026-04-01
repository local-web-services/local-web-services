"""When: an EventBridge rule is deleted."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE, _store


@when('an "eventbridge" "rule" is deleted')
def delete_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)
