"""When: a synchronous execution is started on an express state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, TEST_SM_EXPRESS, _sm_arn


@when("a synchronous execution is started on an express state machine")
def start_sync_execution(lws_session, world):
    try:
        sm_name = world.get("state_machine_name") or TEST_SM_EXPRESS
        resp = lws_session.client("stepfunctions").start_sync_execution(
            stateMachineArn=_sm_arn(sm_name), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
