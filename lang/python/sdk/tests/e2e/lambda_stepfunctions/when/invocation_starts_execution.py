"""When: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function starts an execution of an "ACTIVE" state machine and succeeds')
def invocation_starts_execution(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
