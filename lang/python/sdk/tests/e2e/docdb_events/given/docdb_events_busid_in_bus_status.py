"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbEventsTestClient


@given("busid in bus_status")
def docdb_events_busid_in_bus_status(lws_session):
    DocdbEventsTestClient(lws_session).create_bus()
