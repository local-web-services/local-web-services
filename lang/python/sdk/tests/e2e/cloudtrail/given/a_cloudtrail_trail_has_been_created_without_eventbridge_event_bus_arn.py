"""Given: a cloudtrail trail has been created without EventBridgeEventBusArn"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("a cloudtrail trail has been created without EventBridgeEventBusArn")
def a_cloudtrail_trail_has_been_created_without_eventbridge_event_bus_arn(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
