"""Given: the bus exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given("the bus exists")
def bus_exists(lws_session):
    CognitoEventsTestClient(lws_session).create_bus()
