"""Then: the rule is "ENABLED"."""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EVENTS_TARGET, INT_BUS, INT_RULE


@then('the "eventbridge" "rule" will be "ENABLED"')
def rule_is_enabled_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    expected_state = "ENABLED"
    actual_state = r.json().get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
