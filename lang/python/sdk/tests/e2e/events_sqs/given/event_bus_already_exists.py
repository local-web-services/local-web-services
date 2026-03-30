"""Given: the event bus already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("the event bus already exists")
def event_bus_already_exists(lws_session):
    EventsSqsTestClient(lws_session).create_bus()
