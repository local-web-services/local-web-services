"""Given: the bus existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('the bus existed and was "ACTIVE"')
def bus_exists_and_is_active(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
