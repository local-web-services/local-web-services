"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given("busid in bus_status")
def rds_events_busid_in_bus_status(lws_session):
    RdsEventsTestClient(lws_session).create_bus()
