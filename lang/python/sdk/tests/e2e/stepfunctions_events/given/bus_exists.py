"""Given: the "eventbridge" "bus" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('the "eventbridge" "bus" existed')
def bus_exists(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
