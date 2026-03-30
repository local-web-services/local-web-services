"""Given: bid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given("bid in bus_status")
def events_sfn_bid_in_bus_status(lws_session):
    EventsStepfunctionsTestClient(lws_session).create_bus()
