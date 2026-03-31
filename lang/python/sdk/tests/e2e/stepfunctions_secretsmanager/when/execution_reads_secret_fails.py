"""When: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, _secretsmanager_get_secret_definition, _sm_arn


@when(
    'a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion'
)
def execution_reads_secret_fails(lws_session, world):
    # Arrange
    if "execution_arn" not in world:
        world["result"] = None
        world["error"] = RuntimeError("No execution is RUNNING")
        return
    try:
        resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        if resp.get("DeletedDate") is None:
            world["result"] = None
            world["error"] = RuntimeError(f"Secret {TEST_SECRET} is not pending deletion")
            return
    except ClientError:
        world["result"] = None
        world["error"] = RuntimeError(f"Secret {TEST_SECRET} does not exist")
        return
    # Act
    execution_arn = world["execution_arn"]
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_secretsmanager_get_secret_definition(TEST_SECRET)
        )
    except Exception:
        pass
    lws_session.inject_state("stepfunctions", "execution", execution_arn, "FAILED")
    # Assert
    world["result"] = {"executionArn": execution_arn}
    world["error"] = None
