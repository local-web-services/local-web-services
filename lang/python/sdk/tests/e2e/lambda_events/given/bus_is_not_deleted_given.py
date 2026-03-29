"""Given: the bus is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given(lws_session):
    LambdaEventsTestClient(lws_session).create_bus()
