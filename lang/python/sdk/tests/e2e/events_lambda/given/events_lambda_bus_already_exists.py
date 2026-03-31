"""Given: the event bus already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("the event bus already existed")
def events_lambda_bus_already_exists(lws_session):
    EventsLambdaTestClient(lws_session).create_bus()
