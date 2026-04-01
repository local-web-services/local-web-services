"""Given: an "eventbridge" "rule" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('an "eventbridge" "rule" was "ENABLED"')
def events_ddb_rule_enabled(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
    try:
        EventsDynamodbTestClient(lws_session)._events.enable_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS
        )
    except Exception:
        pass
