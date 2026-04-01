"""Given: bid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given("bid in bus_status")
def events_sns_bid_in_bus_status(lws_session):
    EventsSnsTestClient(lws_session).create_bus()
