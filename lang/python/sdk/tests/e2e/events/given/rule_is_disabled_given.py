"""Given: the "eventbridge" "rule" was "DISABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('the "eventbridge" "rule" was "DISABLED"')
def rule_is_disabled_given(lws_session):
    EventsTestClient(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
