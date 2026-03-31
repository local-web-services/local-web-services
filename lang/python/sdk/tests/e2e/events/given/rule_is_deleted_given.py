"""Given: the "eventbridge" "rule" was "DELETED" (targets cleared)"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE, TEST_TARGET_ID


@given('the "eventbridge" "rule" was "DELETED"')
def rule_is_deleted_given(lws_session):
    """Ensure the rule has no targets (targets were deleted/cleared)."""
    EventsTestClient(lws_session).create_rule()
    try:
        lws_session.client("events").remove_targets(
            Rule=TEST_RULE, EventBusName=TEST_BUS, Ids=[TEST_TARGET_ID]
        )
    except Exception:
        pass
