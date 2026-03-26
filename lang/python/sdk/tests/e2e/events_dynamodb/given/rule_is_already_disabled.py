"""Given: the rule is already "DISABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('the rule is already "DISABLED"')
def rule_is_already_disabled(lws_session):
    EventsDynamodbTestClient(lws_session)._events.disable_rule(
        Name=TEST_RULE, EventBusName=TEST_BUS
    )
