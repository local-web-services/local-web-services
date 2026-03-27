"""When: the Lambda function fails because the secret is pending deletion"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails because the secret is pending deletion")
def invocation_fails_secret_pending(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
