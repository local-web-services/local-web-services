"""Given: the integrated state machine was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient
from ..constants import _sm_arn


@given('the "step functions" "state machine" was not "ACTIVE"')
def apigw_sfn_sm_is_not_active_given(lws_session, world):
    try:
        lws_session.client("stepfunctions").delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
    world["result"] = None
    world["error"] = None
