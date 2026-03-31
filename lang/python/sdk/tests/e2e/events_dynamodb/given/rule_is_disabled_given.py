"""Given: an "eventbridge" "rule" was "DISABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('an "eventbridge" "rule" was "DISABLED"')
def rule_is_disabled_given(lws_session):
    EventsDynamodbTestClient(lws_session)._events.disable_rule(
        Name=TEST_RULE, EventBusName=TEST_BUS
    )
