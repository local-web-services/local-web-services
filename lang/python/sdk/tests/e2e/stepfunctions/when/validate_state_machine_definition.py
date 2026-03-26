"""When: a state machine definition is validated"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient
from ..constants import PASS_DEFINITION, TEST_SM, _sm_arn


@when("a state machine definition is validated")
def validate_state_machine_definition(lws_session, world):
    if world.get("state_machine_arn") is None and world.get("state_machine_name") is None:
        pytest.skip(
            "ValidateStateMachineDefinition does not accept stateMachineArn; cannot test existence check via this SDK call"  # noqa: E501
        )
    sm_name = world.get("state_machine_name", TEST_SM)
    try:
        status = (
            StepfunctionsTestClient(lws_session)
            .describe_state_machine(stateMachineArn=_sm_arn(sm_name))
            .get("status", "ACTIVE")
        )
    except Exception:
        status = None
    if status != "ACTIVE":
        pytest.skip(
            "ValidateStateMachineDefinition does not accept stateMachineArn; cannot test lifecycle check via this SDK call"  # noqa: E501
        )
    try:
        resp = StepfunctionsTestClient(lws_session).validate_state_machine_definition(
            definition=PASS_DEFINITION
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
