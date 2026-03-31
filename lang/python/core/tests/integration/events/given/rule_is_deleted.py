"""Given: the rule is "DELETED"."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE


@given('the "eventbridge" "rule" was "DELETED"')
def rule_is_deleted_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
