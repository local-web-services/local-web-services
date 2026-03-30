"""When: a state machine is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, _sm_arn


@when("a state machine is deleted")
def delete_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DeleteStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
