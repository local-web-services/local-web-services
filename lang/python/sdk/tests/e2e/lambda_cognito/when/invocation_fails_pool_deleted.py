"""When: the Lambda function fails to call Cognito because the pool has been deleted"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails to call Cognito because the pool has been deleted")
def invocation_fails_pool_deleted(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
