"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('the "eventbridge" "bus" already existed')
def event_bus_already_exists(lws_session):
    EventsSnsTestClient(lws_session).create_bus()
