"""Given: the event bus has rules"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("the event bus has rules")
def bus_has_rules(lws_session):
    """Create a rule on the event bus so it is non-empty."""
    EventsTestClient(lws_session).create_rule()
