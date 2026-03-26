"""When: an event is published to the bus and routed to the target "SQS" queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsSqsTestClient
from ..constants import TEST_BUS


@when('an event is published to the bus and routed to the target "SQS" queue')
def put_event_routed_to_sqs(lws_session, world):
    try:
        world["result"] = EventsSqsTestClient(lws_session)._events.put_events(
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
