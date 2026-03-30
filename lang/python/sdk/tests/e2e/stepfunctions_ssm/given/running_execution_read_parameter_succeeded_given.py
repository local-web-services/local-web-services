"""Given: a running execution has read an existing parameter and the task succeeded"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient
from ..constants import TEST_PARAM, _sm_arn, _ssm_get_parameter_definition


@given("a running execution has read an existing parameter and the task succeeded")
def running_execution_read_parameter_succeeded_given(lws_session, world):
    client = StepfunctionsSsmTestClient(lws_session)
    try:
        client.create_sm()
    except Exception:
        pass
    try:
        client.create_param()
    except Exception:
        pass
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_ssm_get_parameter_definition(TEST_PARAM)
        )
    except Exception:
        pass
    try:
        execution_arn = client.start_execution()
        world["execution_arn"] = execution_arn
    except Exception:
        pass
