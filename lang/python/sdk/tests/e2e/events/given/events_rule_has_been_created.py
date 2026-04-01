"""Given: an "eventbridge" "rule" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('an "eventbridge" "rule" is created')
def events_rule_has_been_created(lws_session):
    EventsTestClient(lws_session).create_rule()
