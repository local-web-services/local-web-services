"""When: an execution is started on a standard state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, TEST_SM, _sm_arn


@when("an execution is started on a standard state machine")
def start_execution(lws_session, world):
    try:
        sm_name = world.get("state_machine_name") or TEST_SM
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(sm_name), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
