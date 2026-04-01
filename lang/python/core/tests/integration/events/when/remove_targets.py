"""When: targets are removed from a rule."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE, INT_TARGET_ID, _store


@when('targets are removed from an "eventbridge" "rule"')
def remove_targets(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.RemoveTargets"},
        json={"Rule": INT_RULE, "EventBusName": INT_BUS, "Ids": [INT_TARGET_ID]},
    )
    _store(world, r)
