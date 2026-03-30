"""When: the Lambda function fails to publish because the event bus has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when("the Lambda function fails to publish because the event bus has been deleted")
def invocation_fails_bus_deleted(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("events").describe_event_bus(Name=TEST_BUS)
        world["error"] = RuntimeError("Bus is not deleted")
        return
    except ClientError:
        pass
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
