"""Given: the state machine is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient
from ..constants import _sm_arn


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        StepfunctionsElasticsearchTestClient(lws_session)._sfn.delete_state_machine(
            stateMachineArn=_sm_arn()
        )
    except Exception:
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    StepfunctionsElasticsearchTestClient(lws_session).create_sm()
    world["result"] = None
    world["error"] = None
