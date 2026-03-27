"""When: the Lambda invocation fails"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda invocation fails")
def events_lambda_invocation_fails(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
