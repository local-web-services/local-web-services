"""Then: the rule is "ENABLED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@then('the rule is "ENABLED"')
def rule_is_enabled_then(lws_session):
    resp = EventsTestClient(lws_session).describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    expected_state = "ENABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
