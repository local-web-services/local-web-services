"""When: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function publishes an event to the "ACTIVE" event bus and succeeds')
def publish_event_task(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
