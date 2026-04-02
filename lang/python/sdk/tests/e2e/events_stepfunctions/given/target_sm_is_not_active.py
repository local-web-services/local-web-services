"""Given: the target "step functions" "state machine" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient
from ..constants import _sm_arn


@given('the target "step functions" "state machine" was not "ACTIVE"')
def target_sm_is_not_active(lws_session, world):
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    try:
        lws_session.client("stepfunctions").delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:
        pass
    EventsStepfunctionsTestClient(lws_session).create_sm()
    world["result"] = None
    world["error"] = None
