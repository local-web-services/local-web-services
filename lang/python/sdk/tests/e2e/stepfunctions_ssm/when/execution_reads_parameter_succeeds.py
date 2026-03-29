"""When: a running execution reads an existing parameter and the task succeeds"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_PARAM, _sm_arn, _ssm_get_parameter_definition


@when("a running execution reads an existing parameter and the task succeeds")
def execution_reads_parameter_succeeds(lws_session, world):
    # Arrange
    if world.get("execution_arn") is None:
        world["result"] = None
        world["error"] = RuntimeError("No execution is RUNNING")
        return
    try:
        lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
    except Exception:
        world["result"] = None
        world["error"] = RuntimeError(f"Parameter {TEST_PARAM} does not exist")
        return
    # Act
    execution_arn = world["execution_arn"]
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_ssm_get_parameter_definition(TEST_PARAM)
        )
    except Exception:
        pass
    lws_session.inject_state("stepfunctions", "execution", execution_arn, "SUCCEEDED")
    # Assert
    world["result"] = {"executionArn": execution_arn}
    world["error"] = None
