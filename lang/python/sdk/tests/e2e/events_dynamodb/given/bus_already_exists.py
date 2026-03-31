"""Given: the bus already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("the bus already existed")
def bus_already_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
