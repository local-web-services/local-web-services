"""Given: the bus already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given("the bus already existed")
def bus_already_exists(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
