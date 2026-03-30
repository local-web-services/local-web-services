"""Given: the bus exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given('the bus exists and is "ACTIVE"')
def bus_exists_and_is_active(lws_session):
    CognitoEventsTestClient(lws_session).create_bus()
