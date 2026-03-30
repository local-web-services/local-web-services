"""Given: bus_name in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("bus_name in bus_status")
def bus_name_in_bus_status(lws_session):
    EventsTestClient(lws_session).create_bus()
