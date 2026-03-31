"""When: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when('the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds')
def publish_event_task(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("events").describe_event_bus(Name=TEST_BUS)
    except ClientError:
        world["error"] = RuntimeError("Bus does not exist or is deleted")
        return
    if lws_session.capacity("events").is_exhausted():
        world["error"] = RuntimeError("No event slot is available")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
