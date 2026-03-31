"""Given: an "eventbridge" "bus" is described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('an "eventbridge" "bus" is described')
def events_bus_has_been_described(lws_session):
    EventsTestClient(lws_session).create_bus()
