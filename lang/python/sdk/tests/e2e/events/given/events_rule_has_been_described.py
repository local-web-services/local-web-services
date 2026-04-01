"""Given: an "eventbridge" "rule" is described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('an "eventbridge" "rule" is described')
def events_rule_has_been_described(lws_session):
    EventsTestClient(lws_session).create_rule()
