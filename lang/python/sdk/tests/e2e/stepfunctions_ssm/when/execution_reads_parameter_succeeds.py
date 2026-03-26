"""When: a running execution reads an existing parameter and the task succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSsmTestClient
from ..constants import TEST_INPUT, TEST_PARAM, _sm_arn, _ssm_get_parameter_definition


@when("a running execution reads an existing parameter and the task succeeds")
def execution_reads_parameter_succeeds(lws_session, world):
    try:
        StepfunctionsSsmTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_ssm_get_parameter_definition(TEST_PARAM)
        )
    except Exception:
        pass
    try:
        resp = StepfunctionsSsmTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
