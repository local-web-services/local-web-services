"""Given: an "eventbridge" "bus" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('an "eventbridge" "bus" is created')
def events_sns_seq_bus_created(lws_session):
    EventsSnsTestClient(lws_session).create_bus()
