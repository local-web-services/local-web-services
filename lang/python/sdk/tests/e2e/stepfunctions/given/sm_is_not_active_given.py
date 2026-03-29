"""Given: the state machine is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, _sm_arn


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    """Enable lifecycle simulation so state machine stays in CREATING state."""
    sm_name = world.get("state_machine_name") or TEST_SM
    try:
        StepfunctionsTestClient(lws_session).delete_state_machine(stateMachineArn=_sm_arn(sm_name))
    except Exception:
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
