"""When: a "step functions" "state machine" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import PASS_DEFINITION, ROLE_ARN, TEST_SM


@when('a "step functions" "state machine" is created')
def create_state_machine(lws_session, world):
    try:
        resp = lws_session.client("stepfunctions").create_state_machine(
            name=TEST_SM, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        world["result"] = resp
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = resp["stateMachineArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
