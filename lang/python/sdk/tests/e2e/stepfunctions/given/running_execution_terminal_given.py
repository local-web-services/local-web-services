"""Given: a running execution transitions to a terminal state"""

from __future__ import annotations

import uuid

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..constants import PASS_DEFINITION, ROLE_ARN, TEST_SM


@given("a running execution transitions to a terminal state")
def running_execution_terminal_given(lws_session, world):
    # Arrange
    sm_name = world.get("state_machine_name") or TEST_SM
    if not world.get("state_machine_arn"):
        try:
            resp = lws_session.client("stepfunctions").create_state_machine(
                name=sm_name, definition=PASS_DEFINITION, roleArn=ROLE_ARN
            )
            world["state_machine_arn"] = resp["stateMachineArn"]
        except ClientError:
            world["state_machine_arn"] = (
                f"arn:aws:states:us-east-1:000000000000:stateMachine:{sm_name}"
            )
        world["state_machine_name"] = sm_name
    exec_name = f"injected-{uuid.uuid4().hex[:8]}"
    execution_arn = f"arn:aws:states:us-east-1:000000000000:execution:{sm_name}:{exec_name}"
    # Act
    lws_session.inject_state("stepfunctions", "execution", execution_arn, "SUCCEEDED")
    # Assert
    world["execution_arn"] = execution_arn
