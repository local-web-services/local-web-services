"""When: a running "step functions" "execution" fails to read the parameter because it has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, _sm_arn, _ssm_get_parameter_definition


@when(
    'a running "step functions" "execution" fails to read the parameter because it has been deleted'
)
def execution_reads_parameter_fails(lws_session, world):
    # Arrange
    if world.get("execution_arn") is None:
        world["result"] = None
        world["error"] = RuntimeError("No execution is RUNNING")
        return
    try:
        lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
        world["result"] = None
        world["error"] = RuntimeError(f"Parameter {TEST_PARAM} is not deleted")
        return
    except ClientError:
        pass
    # Act
    execution_arn = world["execution_arn"]
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_ssm_get_parameter_definition(TEST_PARAM),
        )
    except Exception:
        pass
    lws_session.inject_state("stepfunctions", "execution", execution_arn, "FAILED")
    # Assert
    world["result"] = {"executionArn": execution_arn}
    world["error"] = None
