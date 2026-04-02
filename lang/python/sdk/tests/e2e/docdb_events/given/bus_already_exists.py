"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbEventsTestClient


@given('the "eventbridge" "bus" already existed')
def bus_already_exists(lws_session):
    DocdbEventsTestClient(lws_session).create_bus()
