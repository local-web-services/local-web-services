"""Given: the event bus already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("the event bus already exists")
def bus_already_exists(lws_session):
    EventsTestClient(lws_session).create_bus()
