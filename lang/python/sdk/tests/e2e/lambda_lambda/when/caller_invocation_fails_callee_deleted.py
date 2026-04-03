"""When: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CALLEE


@when(
    'the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted'
)
def caller_invocation_fails_callee_deleted(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("lambda").get_function(FunctionName=TEST_CALLEE)
        world["error"] = RuntimeError("Callee is not deleted")
        return
    except ClientError:
        pass
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
