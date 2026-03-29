"""Given: a rule has been disabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@given("a rule has been disabled")
def events_rule_has_been_disabled(lws_session):
    EventsTestClient(lws_session).create_rule()
    try:
        EventsTestClient(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    except Exception:
        pass
