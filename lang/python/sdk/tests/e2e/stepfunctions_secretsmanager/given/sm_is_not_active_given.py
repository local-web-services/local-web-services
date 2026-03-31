"""Given: the "step functions" "state machine" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import _sm_arn


@given('the "step functions" "state machine" was not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        StepfunctionsSecretsmanagerTestClient(lws_session)._sfn.delete_state_machine(
            stateMachineArn=_sm_arn()
        )
    except Exception:
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    StepfunctionsSecretsmanagerTestClient(lws_session).create_sm()
    world["result"] = None
    world["error"] = None
