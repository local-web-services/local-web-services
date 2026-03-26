"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given("busid in bus_status")
def cognito_events_busid_in_bus_status(lws_session):
    CognitoEventsTestClient(lws_session).create_bus()
