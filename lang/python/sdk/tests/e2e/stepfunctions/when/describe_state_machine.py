"""When: a "step functions" "state machine" is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SM, _sm_arn


@when('a "step functions" "state machine" is described')
def describe_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name") or TEST_SM
        resp = lws_session.client("stepfunctions").describe_state_machine(
            stateMachineArn=_sm_arn(sm_name)
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
