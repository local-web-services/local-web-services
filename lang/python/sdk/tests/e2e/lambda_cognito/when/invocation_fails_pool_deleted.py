"""When: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..client import LambdaCognitoTestClient


@when(
    'the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted'
)
def invocation_fails_pool_deleted(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    pool_id = LambdaCognitoTestClient(lws_session).pool_id()
    if pool_id is not None:
        world["error"] = RuntimeError("Pool is not deleted")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
