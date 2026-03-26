"""When: a running execution fails to read the parameter because it has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, TEST_PARAM, _sm_arn, _ssm_get_parameter_definition


@when("a running execution fails to read the parameter because it has been deleted")
def execution_reads_parameter_fails(lws_session, world):
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_ssm_get_parameter_definition(TEST_PARAM)
        )
    except Exception:
        pass
    try:
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
