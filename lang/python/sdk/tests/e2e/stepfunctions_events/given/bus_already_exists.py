"""Given: the bus already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given("the bus already exists")
def bus_already_exists(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
