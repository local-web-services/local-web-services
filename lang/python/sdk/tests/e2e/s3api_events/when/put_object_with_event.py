"""When: an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_BUS, TEST_KEY


@when(
    'an "s3" "object" is uploaded and "s3" delivers an "eventbridge" "event" to the "eventbridge" "bus"'
)
def put_object_with_event(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
        return
    # Verify preconditions: event delivery requires the bus to exist and event slots available
    try:
        lws_session.client("events").describe_event_bus(Name=TEST_BUS)
    except Exception as bus_exc:
        world["result"] = None
        world["error"] = bus_exc
        return
    if lws_session.capacity("events").is_exhausted():
        world["result"] = None
        world["error"] = Exception("lws: event capacity exhausted")
        return
    world["error"] = None
