"""Given: a cloudtrail trail with EventBridgeEventBusArn is logging"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("a cloudtrail trail with EventBridgeEventBusArn is logging")
def a_cloudtrail_trail_with_eventbridge_event_bus_arn_is_logging(lws_session):
    client = CloudtrailTestClient(lws_session)
    client.create_trail_with_bus()
    client.start_logging()
