"""When: an event is published to the bus and triggers a new Step Functions execution"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when("an event is published to the bus and triggers a new Step Functions execution")
def put_event_triggers_sfn(lws_session, world):
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
