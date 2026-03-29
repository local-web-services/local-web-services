"""When: an EventBridge rule is described."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE, _store


@when("an EventBridge rule is described")
def describe_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)
