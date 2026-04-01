"""Given: the event bus existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("the event bus existed")
def events_lambda_bus_exists(lws_session):
    EventsLambdaTestClient(lws_session).create_bus()
