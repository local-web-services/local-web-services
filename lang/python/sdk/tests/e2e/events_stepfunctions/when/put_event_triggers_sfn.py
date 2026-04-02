"""When: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"'
)
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
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
        return
    if lws_session.capacity("stepfunctions").is_exhausted():
        world["result"] = None
        world["error"] = Exception("lws: stepfunctions capacity exhausted")
        return
    world["error"] = None
