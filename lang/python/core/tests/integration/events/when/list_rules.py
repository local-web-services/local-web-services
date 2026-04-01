"""When: all rules on an event bus are listed."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, _store


@when('all rules on an "eventbridge" "bus" are listed')
def list_rules(client: TestClient, world):
    r = client.post(
        "/", headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListRules"}, json={"EventBusName": INT_BUS}
    )
    _store(world, r)
