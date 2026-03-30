"""Given: the rule is "DISABLED"."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE


@given('the rule is "DISABLED"')
def rule_is_disabled_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DisableRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
