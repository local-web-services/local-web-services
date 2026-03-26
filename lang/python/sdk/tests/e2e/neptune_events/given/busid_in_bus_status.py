"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given("busid in bus_status")
def busid_in_bus_status(lws_session):
    NeptuneEventsTestClient(lws_session).create_bus()
