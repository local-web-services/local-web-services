"""Given: bid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("bid in bus_status")
def events_sqs_bid_in_bus_status(lws_session):
    EventsSqsTestClient(lws_session).create_bus()
