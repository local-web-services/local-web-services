"""When: targets for a rule are listed."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE, _store


@when("targets for a rule are listed")
def list_targets_by_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListTargetsByRule"},
        json={"Rule": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)
