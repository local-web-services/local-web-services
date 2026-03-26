"""Given: the rule is already "DELETED"."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE


@given('the rule is already "DELETED"')
def rule_is_already_deleted_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
