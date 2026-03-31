"""When: a "step functions" "state machine" definition is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, UPDATED_DEFINITION, _sm_arn


@when('a "step functions" "state machine" definition is updated')
def update_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.UpdateStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name), "definition": UPDATED_DEFINITION},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
