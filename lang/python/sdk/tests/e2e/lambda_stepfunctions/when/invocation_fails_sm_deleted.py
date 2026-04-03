"""When: the Lambda function fails to start an execution because the state machine is deleted."""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _sm_arn


@when(
    'the "lambda" "function" fails to start an execution because the state machine has been deleted'
)
def invocation_fails_sm_deleted(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("stepfunctions").describe_state_machine(stateMachineArn=_sm_arn())
        world["error"] = RuntimeError("State machine is not deleted")
        return
    except ClientError:
        pass
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
