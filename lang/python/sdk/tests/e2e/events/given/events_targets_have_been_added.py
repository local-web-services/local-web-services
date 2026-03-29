"""Given: targets have been added to a rule"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("targets have been added to a rule")
def events_targets_have_been_added(lws_session):
    EventsTestClient(lws_session).put_target()
