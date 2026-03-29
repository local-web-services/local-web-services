"""When: a state machine definition is updated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SM, UPDATED_DEFINITION, _sm_arn


@when("a state machine definition is updated")
def update_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name") or TEST_SM
        resp = lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(sm_name), definition=UPDATED_DEFINITION
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
