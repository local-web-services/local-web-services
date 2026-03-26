"""When: a running execution fails to read the secret because it is pending deletion"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, TEST_SECRET, _secretsmanager_get_secret_definition, _sm_arn


@when("a running execution fails to read the secret because it is pending deletion")
def execution_reads_secret_fails(lws_session, world):
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_secretsmanager_get_secret_definition(TEST_SECRET)
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
