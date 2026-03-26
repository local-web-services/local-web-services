"""When: a Step Functions state machine is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _sm_arn


@when("a Step Functions state machine is deleted")
def delete_state_machine(lws_session, world):
    try:
        lws_session.client("stepfunctions").delete_state_machine(stateMachineArn=_sm_arn())
        world["result"] = {"stateMachineArn": _sm_arn()}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
