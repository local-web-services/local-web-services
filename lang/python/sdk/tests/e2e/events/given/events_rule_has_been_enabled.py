"""Given: a rule has been enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@given("a rule has been enabled")
def events_rule_has_been_enabled(lws_session):
    EventsTestClient(lws_session).create_rule()
    try:
        EventsTestClient(lws_session).enable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    except Exception:
        pass
