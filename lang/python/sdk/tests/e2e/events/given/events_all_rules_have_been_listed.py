"""Given: all rules on an event bus have been listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("all rules on an event bus have been listed")
def events_all_rules_have_been_listed(lws_session):
    EventsTestClient(lws_session).create_bus()
