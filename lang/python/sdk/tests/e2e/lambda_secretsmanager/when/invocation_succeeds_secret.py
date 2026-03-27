"""When: the Lambda function reads an "ACTIVE" secret and completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function reads an "ACTIVE" secret and completes successfully')
def invocation_succeeds_secret(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
