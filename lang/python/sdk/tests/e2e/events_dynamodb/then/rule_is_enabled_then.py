"""Then: the "eventbridge" "rule" will be "ENABLED" and will match events"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUS, TEST_RULE


@then('the "eventbridge" "rule" will be "ENABLED" and will match events')
def rule_is_enabled_then(lws_session):
    resp = lws_session.client("events").describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    expected_state = "ENABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
