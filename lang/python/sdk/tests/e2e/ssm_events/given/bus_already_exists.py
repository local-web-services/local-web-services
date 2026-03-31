"""Given: the bus already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmEventsTestClient


@given("the bus already existed")
def bus_already_exists(lws_session):
    SsmEventsTestClient(lws_session).create_bus()
