"""Given: the event bus exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("the event bus exists")
def bus_exists(lws_session):
    EventsTestClient(lws_session).create_bus()
