"""When: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"'
)
def put_event_to_bus_routed_to_sns(lws_session, world):
    try:
        world["result"] = lws_session.client("events").put_events(
            Entries=[
                {
                    "EventBusName": TEST_BUS,
                    "Source": "test.source",
                    "DetailType": "TestEvent",
                    "Detail": '{"key": "value"}',
                }
            ]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
