"""Then: the rule is "DISABLED" and will not match events"""

from __future__ import annotations

from pytest_bdd import then

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@then('the rule is "DISABLED" and will not match events')
def rule_is_disabled_then(lws_session):
    resp = EventsDynamodbTestClient(lws_session)._events.describe_rule(
        Name=TEST_RULE, EventBusName=TEST_BUS
    )
    expected_state = "DISABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"
