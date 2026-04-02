"""Given: an "eventbridge" "bus" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given('an "eventbridge" "bus" is created')
def events_sfn_seq_bus_created(lws_session):
    EventsStepfunctionsTestClient(lws_session).create_bus()
