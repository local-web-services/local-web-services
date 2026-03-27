"""When: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the caller Lambda function invokes the "ACTIVE" callee and the call succeeds')
def caller_invokes_callee_succeeds(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
