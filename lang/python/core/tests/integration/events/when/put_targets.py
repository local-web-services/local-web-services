"""When: targets are added to a rule."""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE, INT_TARGET_ARN, INT_TARGET_ID, _store


@when("targets are added to a rule")
def put_targets(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutTargets"},
        json={
            "Rule": INT_RULE,
            "EventBusName": INT_BUS,
            "Targets": [{"Id": INT_TARGET_ID, "Arn": INT_TARGET_ARN}],
        },
    )
    _store(world, r)
