"""When: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _sm_arn


@when('the Lambda function starts an execution of an "ACTIVE" state machine and succeeds')
def invocation_starts_execution(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("stepfunctions").describe_state_machine(stateMachineArn=_sm_arn())
    except ClientError:
        world["error"] = RuntimeError("State machine does not exist or is deleted")
        return
    if lws_session.capacity("stepfunctions").is_exhausted():
        world["error"] = RuntimeError("No execution slot is available")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
