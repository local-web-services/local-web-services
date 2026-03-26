"""Then: the rule is "ENABLED" and will trigger the function when matching events are published"""

from __future__ import annotations

from pytest_bdd import then

from ..client import EventsLambdaTestClient
from ..constants import TEST_BUS, TEST_RULE


@then('the rule is "ENABLED" and will trigger the function when matching events are published')
def rule_is_enabled(lws_session):
    resp = EventsLambdaTestClient(lws_session)._events.describe_rule(
        Name=TEST_RULE, EventBusName=TEST_BUS
    )
    expected_state = "ENABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
