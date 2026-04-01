"""Given: a cloudtrail trail is configured with an EventBridgeEventBusArn that does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient
from ..constants import TEST_TRAIL

_NONEXISTENT_BUS = "e2e-nonexistent-bus-99"
NONEXISTENT_BUS_ARN = f"arn:aws:events:us-east-1:123456789012:event-bus/{_NONEXISTENT_BUS}"


@given("a cloudtrail trail is configured with an EventBridgeEventBusArn that does not exist")
def a_cloudtrail_trail_is_configured_with_an_eventbridge_event_bus_arn_that_does_not_exist(
    lws_session,
):
    client = CloudtrailTestClient(lws_session)
    client.create_trail()
    ct = lws_session.client("cloudtrail")
    try:
        ct.update_trail(Name=TEST_TRAIL, EventBridgeEventBusArn=NONEXISTENT_BUS_ARN)
    except Exception:
        pass
