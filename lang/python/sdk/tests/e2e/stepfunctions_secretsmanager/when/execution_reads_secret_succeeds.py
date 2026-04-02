"""When: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET, _secretsmanager_get_secret_definition, _sm_arn


@when('a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds')
def execution_reads_secret_succeeds(lws_session, world):
    # Arrange
    if world.get("execution_arn") is None:
        world["result"] = None
        world["error"] = RuntimeError("No execution is RUNNING")
        return
    try:
        resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        if resp.get("DeletedDate") is not None:
            world["result"] = None
            world["error"] = RuntimeError(f"Secret {TEST_SECRET} is not ACTIVE")
            return
    except ClientError:
        world["result"] = None
        world["error"] = RuntimeError(f"Secret {TEST_SECRET} does not exist")
        return
    # Act
    execution_arn = world["execution_arn"]
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_secretsmanager_get_secret_definition(TEST_SECRET),
        )
    except Exception:
        pass
    lws_session.inject_state("stepfunctions", "execution", execution_arn, "SUCCEEDED")
    # Assert
    world["result"] = {"executionArn": execution_arn}
    world["error"] = None
