"""Given: the state machine is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient
from ..constants import _sm_arn


@given('the state machine is already "DELETED"')
def sm_is_already_deleted(lws_session, world):
    try:
        LambdaStepfunctionsTestClient(lws_session).create_sm()
    except Exception:
        pass
    lws_session.lifecycle("stepfunctions").delete_dwell_ms(5000).apply()
    try:
        LambdaStepfunctionsTestClient(lws_session)._sfn.delete_state_machine(
            stateMachineArn=_sm_arn()
        )
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
