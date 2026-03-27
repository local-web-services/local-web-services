"""When: the Lambda function fails to start an execution because the state machine is deleted."""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails to start an execution because the state machine has been deleted")
def invocation_fails_sm_deleted(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
