"""When: a running execution reads an "ACTIVE" secret and the task succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_INPUT, TEST_SECRET, _secretsmanager_get_secret_definition, _sm_arn


@when('a running execution reads an "ACTIVE" secret and the task succeeds')
def execution_reads_secret_succeeds(lws_session, world):
    try:
        StepfunctionsSecretsmanagerTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_secretsmanager_get_secret_definition(TEST_SECRET)
        )
    except Exception:
        pass
    try:
        resp = StepfunctionsSecretsmanagerTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
