"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given('the "eventbridge" "bus" already existed')
def bus_already_exists(lws_session):
    RdsEventsTestClient(lws_session).create_bus()
