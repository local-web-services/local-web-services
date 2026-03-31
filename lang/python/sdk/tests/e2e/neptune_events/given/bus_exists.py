"""Given: the bus existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given("the bus existed")
def bus_exists(lws_session):
    NeptuneEventsTestClient(lws_session).create_bus()
