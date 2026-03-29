"""Given: targets for a rule have been listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("targets for a rule have been listed")
def events_targets_for_rule_have_been_listed(lws_session):
    EventsTestClient(lws_session).create_rule()
