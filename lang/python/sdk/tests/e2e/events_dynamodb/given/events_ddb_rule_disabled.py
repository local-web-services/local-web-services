"""Given: an "eventbridge" "rule" was "DISABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('the rule was "DISABLED"')
def events_ddb_rule_disabled(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
    try:
        EventsDynamodbTestClient(lws_session)._events.disable_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS
        )
    except Exception:
        pass
