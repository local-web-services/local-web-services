"""Given: the bus exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbEventsTestClient


@given("the bus exists")
def bus_exists(lws_session):
    DocdbEventsTestClient(lws_session).create_bus()
