"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("busid in bus_status")
def events_ddb_busid_in_bus_status(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
