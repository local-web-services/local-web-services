"""Given: the bus is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
