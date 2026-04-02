"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given('the "eventbridge" "bus" already existed')
def bus_already_exists(lws_session):
    LambdaEventsTestClient(lws_session).create_bus()
