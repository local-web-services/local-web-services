"""Given: the event bus existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given("the event bus existed")
def event_bus_exists(lws_session):
    EventsSnsTestClient(lws_session).create_bus()
