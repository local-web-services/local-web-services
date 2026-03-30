"""Given: bid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("bid in bus_status")
def events_lambda_bid_in_bus_status(lws_session):
    EventsLambdaTestClient(lws_session).create_bus()
