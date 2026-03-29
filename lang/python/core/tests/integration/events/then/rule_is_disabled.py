"""Then: the rule is "DISABLED"."""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE


@then('the rule is "DISABLED"')
def rule_is_disabled_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    expected_state = "DISABLED"
    actual_state = r.json().get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
