"""Given: an EventBridge rule has been described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("an EventBridge rule has been described")
def events_rule_has_been_described(lws_session):
    EventsTestClient(lws_session).create_rule()
