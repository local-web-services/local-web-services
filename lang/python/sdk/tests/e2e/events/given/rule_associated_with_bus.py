"""Given: no eventbridge rule is associated with the "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('an "eventbridge" "rule" is associated with the "eventbridge" "bus"')
def rule_associated_with_bus(lws_session):
    EventsTestClient(lws_session).create_rule()
