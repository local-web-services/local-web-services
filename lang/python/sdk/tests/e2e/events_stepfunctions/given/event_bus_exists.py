"""Given: the "eventbridge" "bus" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given('the "eventbridge" "bus" existed')
def event_bus_exists(lws_session):
    EventsStepfunctionsTestClient(lws_session).create_bus()
