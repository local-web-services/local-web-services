"""Given: the bus already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given("the bus already exists")
def bus_already_exists(lws_session):
    NeptuneEventsTestClient(lws_session).create_bus()
