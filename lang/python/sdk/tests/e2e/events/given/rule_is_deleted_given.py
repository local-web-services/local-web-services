"""Given: the "eventbridge" "rule" was "DELETED"."""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('the "eventbridge" "rule" was "DELETED"')
def rule_is_deleted_given(lws_session):
    EventsTestClient(lws_session).create_rule()
    lws_session.client("events").delete_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
