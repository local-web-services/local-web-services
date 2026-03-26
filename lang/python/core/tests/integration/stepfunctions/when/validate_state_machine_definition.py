"""When: a state machine definition is validated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, PASS_DEFINITION, _sm_arn


@when("a state machine definition is validated")
def validate_state_machine_definition(client: TestClient, world):
    sm_name = world.get("state_machine_name")
    if sm_name is None:
        world["error"] = {
            "__type": "StateMachineDoesNotExist",
            "message": "State machine does not exist",
        }
        return
    # Check if the state machine is ACTIVE before validating
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if desc_r.status_code != 200 or desc_r.json().get("status") != "ACTIVE":
        world["error"] = {
            "__type": "StateMachineDoesNotExist",
            "message": "State machine is not ACTIVE",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ValidateStateMachineDefinition"},
        json={"definition": PASS_DEFINITION},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
