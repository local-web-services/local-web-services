"""Given: the "eventbridge" "bus" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('the "eventbridge" "bus" was not "DELETED"')
def bus_is_not_deleted_given(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
