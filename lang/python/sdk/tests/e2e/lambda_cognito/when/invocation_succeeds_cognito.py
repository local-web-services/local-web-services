"""When: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds"""

from __future__ import annotations

from pytest_bdd import when

from ..client import LambdaCognitoTestClient


@when('the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds')
def invocation_succeeds_cognito(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    pool_id = LambdaCognitoTestClient(lws_session).pool_id()
    if pool_id is None:
        world["error"] = RuntimeError("Pool does not exist or is deleted")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
