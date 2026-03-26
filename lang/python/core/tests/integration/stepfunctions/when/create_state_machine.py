"""When: a Step Functions state machine is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, PASS_DEFINITION, ROLE_ARN, _sm_arn


@when("a Step Functions state machine is created")
def create_state_machine(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.CreateStateMachine"},
        json={"name": INT_SM, "definition": PASS_DEFINITION, "roleArn": ROLE_ARN},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = world["result"].get("stateMachineArn", _sm_arn(INT_SM))
    else:
        world["error"] = r.json()
