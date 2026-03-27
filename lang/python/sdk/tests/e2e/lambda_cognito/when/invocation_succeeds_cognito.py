"""When: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds')
def invocation_succeeds_cognito(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
